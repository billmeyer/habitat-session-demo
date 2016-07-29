pkg_origin=billmeyer
pkg_name=session-demo
pkg_version=0.1.0
pkg_maintainer="Bill Meyer <bill@chef.io>"
pkg_license=(MIT)
pkg_source=http://billmeyer.me/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=74248dee62b870853b3c6be84724e702d33d216512201f99cbc56d9cd491d8ec
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/maven core/which core/tomcat8)
pkg_expose=(8080)

do_build() {
  # Ant requires JAVA_HOME to be set, and can be set via:
  export JAVA_HOME=$(hab pkg path core/jdk8)
  mvn package
}

do_install() {
  # Our source files were copied over to the HAB_CACHE_SRC_PATH in do_build(),
  # so now they need to be copied into the root directory of our package through
  # the pkg_prefix variable. This is so that we have the source files available
  # in the package.

  local source="$HAB_CACHE_SRC_PATH/$pkg_dirname"
  echo "\$source=$source"
  webapps_dir="$(hab pkg path core/tomcat8)/tc/webapps"
  cp ${source}/target/session-demo.war ${webapps_dir}/
}
