local common = import '.drone-templates/common.libsonnet';
local images = import '.drone-templates/images.libsonnet';
local renovate = import '.drone-templates/renovate.libsonnet';

local secrets = common.secrets;

local containers = [
  {
    dir: 'ci/bulldozer',
    image: 'bulldozer',
  },
  {
    dir: 'ci/policy-bot',
    image: 'policy-bot',
  },
];

local buildStep(c) = {
  commands: [
    'docker buildx create --use --name drone --node drone0',
    'cd ' + c.dir,
    'docker buildx build --platform linux/arm64 --push -t ghcr.io/ogkevin/' + c.image + ':build-${DRONE_BUILD_NUMBER} -t ghcr.io/ogkevin/' + c.image + ':${DRONE_COMMIT} .',
  ],
  image: 'docker:' + images.docker.version,
  name: 'build ' + c.image,
  depends_on: [
    'docker login',
  ],
  volumes: [
    {
      name: 'docker-login',
      path: '/root/.docker',
    },
    {
      name: 'dockersock',
      path: '/var/run/docker.sock',
    },
  ],
};

local pipeline = common.platform + common.defaultPushTrigger + {
  kind: 'pipeline',
  name: 'docker-build',
  steps: [
    {
      commands: [
        'echo $GHCR_TOKEN | docker login ghcr.io -u $GHCR_USER --password-stdin',
        'echo $DOCKERHUB_TOKEN | docker login -u $DOCKERHUB_USER --password-stdin',
        'cp /root/.docker/config.json /docker',
      ],
      environment: {
        GHCR_TOKEN: {
          from_secret: secrets.ghcr_token.name,
        },
        GHCR_USER: {
          from_secret: secrets.ghcr_user.name,
        },
        DOCKERHUB_TOKEN: {
          from_secret: secrets.dockerhub_token.name,
        },
        DOCKERHUB_USER: {
          from_secret: secrets.dockerhub_user.name,
        },
      },
      image: 'docker:' + images.docker.version,
      name: 'docker login',
      volumes: [
        {
          name: 'docker-login',
          path: '/docker',
        },
      ],
    },
  ] + std.map(buildStep, containers),
  type: 'docker',
  volumes: [
    {
      name: 'docker-login',
      temp: {},
    },
    {
      host: {
        path: '/var/run/docker.sock',
      },
      name: 'dockersock',
    },
  ],
};

[pipeline] + renovate +
[
  x[1]
  for x in common.f.kv(common.secrets)
]
