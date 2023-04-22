#include <iostream>
#include <string>
#include "config.h"
#include "my_application.h"

void print_version_info();

int main(int argc, char** argv) {
  if (argc > 1){
    std::string cmdArg(argv[1]);
    if (cmdArg == "-v" || cmdArg == "--version"){
      print_version_info();
      return 0;
    }
  }

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}

void print_version_info() {
  std::cout << PROJECT_NAME << " " << PROJECT_VER << std::endl;
  std::cout << PROJECT_DESC << std::endl;
  std::cout << "Homepage: https://www.linux-assistant.org" << std::endl;
}
