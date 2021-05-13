{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "UMLS";
  version = "2021AA";

  srcs = [
    ./src
    ../working/.
    (pkgs.fetchzip {
      url = "https://download.nlm.nih.gov/umls/kss/2021AA/umls-2021AA-full.zip";
      sha256 = "2r9xDnE2h6nnGvLssi7E4dFlqACCc4zU9DmjMVlS5oA=";

      netrcImpureEnvVars = [ "UMLS_API_KEY" ];
      netrcPhase = ''
        if [ -z "$UMLS_API_KEY" ]
        then
          echo 'Environment variable UMLS_API_KEY is required, exiting'
          exit 1
        fi

        echo 'generating ticket granting ticket using $UMLS_API_KEY'
        TGT=$(curl --insecure -d "apikey=$UMLS_API_KEY" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://utslogin.nlm.nih.gov/cas/v1/api-key | grep -oP '(?<=api-key/).*?(?=")')

        echo "generating ticket for $urls"
        TICKET=$(curl --insecure -d "service=$urls" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://utslogin.nlm.nih.gov/cas/v1/tickets/$TGT)

        urls=$urls?ticket=$TICKET
      '';
    })
  ];

  sourceRoot = "src";

  nativeBuildInputs = [
    pkgs.unzip
    pkgs.postgresql_13
  ];

  buildPhase = ''
    pwd
    ls -la
    ls -la ../
    ls -la ../source
    # start pg_sql with fresh database
    # only connectible through socket in the build directory
    pg_ctl init -D $TMP/pgdata -o '--auth-host=reject --auth-local=trust'
    pg_ctl start -o '-k $TMP -h ""' -D $TMP/pgdata

    export PGDATABASE=postgres
    export PGHOST=$TMP

    psql -f ../working/DevV5_DDL.sql
    psql -c 'CREATE SCHEMA SOURCES'
    psql -f create_source_tables.sql
  '';

  installPhase = ''
    mkdir -p $out
  '';

}
