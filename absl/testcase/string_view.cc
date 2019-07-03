#include <iostream>
#include <string>
#include <absl/strings/string_view.h>
#include <absl/strings/str_cat.h>

void Show(absl::string_view sv) {  // 使用值传递
  std::cout << sv << std::endl;
}
void StrCat() {
  absl::string_view sv = " hello";
  std::string str = " world";
  const char *cstr = " abc ";
  int i = 55;
  double f = 123.44678;
  std::string res = absl::StrCat(sv, str, cstr, i, f);
  std::cout << res << std::endl;
}
int main() {
  absl::string_view sv = "Tired"; 
  Show(sv);  // 使用值传递

  std::string str = "like";
  Show(str);  // 实参可以直接使用 std::string 类型
  Show("dog"); // 实参可以直接使用 const char* 类型

  return 0;
}
