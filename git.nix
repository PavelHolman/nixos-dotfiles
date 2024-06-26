{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Pavel Holman";
    ignores = [
      ".idea"
      ".user"
    ];
  };

 home.file.".gitconfig".text = ''
    [includeIf "gitdir:~/Deels/"]
      path = ~/.gitconfig-deels
    [includeIf "gitdir:~/Merica/"]
      path = ~/.gitconfig-merica
    [includeIf "gitdir:~/FIT/"]
      path = ~/.gitconfig-fit
    [includeIf "gitdir:~/MFF/"]
      path = ~/.gitconfig-mff
  '';

  home.file.".gitconfig-deels".text = ''
    [user]
      email = "pavelholman1@gmail.com"

    [core]
      autocrlf = false
  '';

  home.file.".gitconfig-merica".text = ''
    [user]
      email = "pavelholman@email.cz"

    [core]
      autocrlf = false
  '';

  home.file.".gitconfig-mff".text = ''
    [user]
      email = "holmapav@cvut.cz"
  '';

  home.file.".gitconfig-fit".text = ''
    [user]
      email = "holmapav@fit.cvut.cz"
  '';
}
