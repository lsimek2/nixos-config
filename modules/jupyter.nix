{ config, pkgs, ... }:
let
  sci = pkgs.python3.withPackages (ps: [
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

  # services.jupyter.password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$FkU3S77MRxrAIcTepYvK0Q$s93Kyu/+TdjOnlb+zApKFiz6wemdrsAneNwl7VR8O6U";

  services.jupyter.password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$xo/dReoYyWqAueQIENHlEg$GvuZAqpUPcltQsSMz/4viVr1CNxUol6WhUk5Ht+O2es";

  services.jupyter = {
    user = "lsimek";
    group = "users";
    command = "jupyter lab";
  };

  services.jupyter.kernels = {
    sci = {
      displayName = "sci";
      argv = [
        "${sci.interpreter}"
        "-m"
        "ipykernel_launcher"
        "-f"
        "{connection_file}"
      ];
      language = "python";
      logo32 = "${sci}/${sci.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${sci}/${sci.sitePackages}/ipykernel/resources/logo-64x64.png";
    };
  };

}
