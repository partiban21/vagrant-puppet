class profiles::java (
  String $java_package = 'java-1.8.0-openjdk-devel',
){

  class { 'java' :
    package => $java_package,
  }
  
}
