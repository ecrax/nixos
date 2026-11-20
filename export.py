import os

with open("./export.txt", "w") as export_file:
    for root, subdirs, files in os.walk("."):
        for file in files:
            if file.endswith(".nix"):
                path = os.path.join(root, file)
                with open(path, "r") as nix_file:
                    export_file.write("\n")
                    export_file.write("path: " + str(path) + "\n")
                    export_file.write(nix_file.read())
