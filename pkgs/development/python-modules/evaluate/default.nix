{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  datasets,
  dill,
  fsspec,
  huggingface-hub,
  importlib-metadata,
  multiprocess,
  numpy,
  packaging,
  pandas,
  requests,
  setuptools,
  tqdm,
  xxhash,
}:

buildPythonPackage rec {
  pname = "evaluate";
  version = "0.4.5";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "evaluate";
    tag = "v${version}";
    hash = "sha256-YcKlGun9zZdr8l2Oz49J8OYV9/VUHyyGyaJk/7PGS0o=";
  };

  build-system = [ setuptools ];

  dependencies = [
    datasets
    numpy
    dill
    pandas
    requests
    tqdm
    xxhash
    multiprocess
    fsspec
    huggingface-hub
    packaging
  ]
  ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ];

  # most tests require internet access.
  doCheck = false;

  pythonImportsCheck = [ "evaluate" ];

  meta = with lib; {
    homepage = "https://huggingface.co/docs/evaluate/index";
    description = "Easily evaluate machine learning models and datasets";
    changelog = "https://github.com/huggingface/evaluate/releases/tag/${src.tag}";
    license = licenses.asl20;
    maintainers = with maintainers; [ bcdarwin ];
    mainProgram = "evaluate-cli";
  };
}
