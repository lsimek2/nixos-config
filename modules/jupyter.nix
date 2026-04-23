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

  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium
        textpos
        etextools
        environ
        fmtcount
        koma-script
        babel
        babel-croatian
        datetime
        geometry
        amsfonts
        csquotes
        tcolorbox
        pgf
        pgfplots
        arydshln
        float
        xcolor
        breqn
        thmtools
        multirow
        hyperref
        booktabs
        listings
        letltxmacro
        adjustbox
        enumitem
        biblatex
        placeins
        mathtools
        autonum
        url
        subfiles
        nowidow
        type1cm
        ;
    }
  );

in
{
  systemd.services.jupyter.path = [ tex ];

  services.jupyter.enable = true;
  environment.systemPackages = [
    pkgs.jupyter-all
    tex
  ];

  networking.firewall.allowedTCPPorts = [ 8889 ];
  networking.firewall.allowedUDPPorts = [ 8889 ];

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

      env = {
        TEXMFHOME = "${tex}/share/texmf";
      };
    };
  };
}
