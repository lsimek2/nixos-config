{ config, pkgs, ... }:
let
  python-scienv = pkgs.python3.withPackages (ps: [
    ps.ipykernel
    ps.pandas
    ps.numpy
    ps.matplotlib
    ps.scikit-learn
    ps.scipy
    ps.seaborn
  ]);
in
{
  services.jupyter.enable = true;
  environment.systemPackages = [ pkgs.jupyter-all ];

  services.jupyter.password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$FkU3S77MRxrAIcTepYvK0Q$s93Kyu/+TdjOnlb+zApKFiz6wemdrsAneNwl7VR8O6U";

  services.jupyter = {
    user = "lsimek";
    group = "users";
    command = "jupyter lab";
  };

  services.jupyter.kernels = {
    clojure = pkgs.clojupyter.definition;

    octave = pkgs.octave-kernel.definition;

    python-datascience = {
      displayName = "py-scienv";
      argv = [
        "${python-scienv.interpreter}"
        "-m"
        "ipykernel_launcher"
        "-f"
        "{connection_file}"
      ];
      language = "python";
      logo32 = "${python-scienv}/${python-scienv.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${python-scienv}/${python-scienv.sitePackages}/ipykernel/resources/logo-64x64.png";
    };
  };

}
