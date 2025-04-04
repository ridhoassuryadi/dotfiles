{ config, lib, pkgs, ... }:

let
  postgresqlPackage = pkgs.postgresql_16;
  pgDataDir = "${config.home.homeDirectory}/.postgres_data";
  pgLogFile = "${pgDataDir}/postgres.log";
in {
  options.postgres.enable = lib.mkEnableOption "PostgreSQL database";

  config = lib.mkIf config.postgres.enable {
    home.packages = [ postgresqlPackage ];

    home.sessionVariables = {
      PGDATA = pgDataDir;
      PGHOST = "localhost";
      PGPORT = "5432";
    };

    home.activation.postgresSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${pgDataDir}" ]; then
        echo "Initializing PostgreSQL in ${pgDataDir}"
        ${postgresqlPackage}/bin/initdb \
          -D "${pgDataDir}" \
          --no-locale \
          --encoding=UTF8 \
          --auth=trust \
          --username="$USER"

        echo "host all all 127.0.0.1/32 trust" >> "${pgDataDir}/pg_hba.conf"
        echo "host all all ::1/128 trust" >> "${pgDataDir}/pg_hba.conf"

        # Start PostgreSQL temporarily to create default database
        ${postgresqlPackage}/bin/pg_ctl -D "${pgDataDir}" -l "${pgLogFile}" start
        ${postgresqlPackage}/bin/createdb "$USER"
        ${postgresqlPackage}/bin/pg_ctl -D "${pgDataDir}" stop
      fi
    '';
  };
}