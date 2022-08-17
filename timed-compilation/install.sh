#!/bin/bash

REPO=https://github.com/michaelb/sniprun


cd ~
rm -rf repo
git clone $REPO repo
cd repo
cargo fetch



cd ~
cat <<EOF > timed-compilation
#!/bin/bash

set -e
BUILD_TYPE=\$1 # "--release" or ""--debug"
INCLUDE_DEPS=\$2 # "yes" or "no": whether to measure compilation from scratch, incl. dependencies, or just the current crate

cd repo

if [ \$INCLUDE_DEPS = "no" ];then
	cargo build \$BUILD_TYPE  >> \$LOG_FILE 2>&1  # compile all the dependencies
	start=\$(date +%s%3N)
	cargo build \$BUILD_TYPE  >> \$LOG_FILE 2>&1  # recompile (only) the current project
	end=\$(date +%s%3N)
else
	start=\$(date +%s%3N)
	cargo build \$BUILD_TYPE  >> \$LOG_FILE 2>&1
	end=\$(date +%s%3N)
fi

duration=\$((end - start))
echo "\nCompile time: \$duration ms" >> \$LOG_FILE 

EOF

chmod +x timed-compilation
