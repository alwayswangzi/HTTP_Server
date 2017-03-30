#ifndef HTTP_REQUEST_PARSER_HPP
#define HTTP_REQUEST_PARSER_HPP

#include <tuple>

namespace http {
namespace server {

struct request;

/// Parser for incoming requests.
// 来自客户端请求的解析器
class request_parser
{
public:
  /// Construct ready to parse the request method.
  // 构建准备解析请求方法
  request_parser();

  /// Reset to initial parser state.
  // 重置为初始解析器的状态
  void reset();

  /// Result of parse.
  // 解析结果：好，坏，未定义
  enum result_type { good, bad, indeterminate };

  /// Parse some data. The enum return value is good when a complete request has
  /// been parsed, bad if the data is invalid, indeterminate when more data is
  /// required. The InputIterator return value indicates how much of the input
  /// has been consumed.
  // 输入迭代器
  template <typename InputIterator>
  std::tuple<result_type, InputIterator> parse(request& req,
      InputIterator begin, InputIterator end)
  {
    while (begin != end)
    {
      result_type result = consume(req, *begin++);
      if (result == good || result == bad)
        return std::make_tuple(result, begin);
    }
    return std::make_tuple(indeterminate, begin);
  }

private:
  /// Handle the next character of input.
  // 处理下一个输入的字符
  result_type consume(request& req, char input);

  /// Check if a byte is an HTTP character.
  static bool is_char(int c);

  /// Check if a byte is an HTTP control character.
  // 是一个控制字符
  static bool is_ctl(int c);

  /// Check if a byte is defined as an HTTP tspecial character.
  // 特殊字符
  static bool is_tspecial(int c);

  /// Check if a byte is a digit.
  static bool is_digit(int c);

  /// The current state of the parser.
  // 解析器目前的状态
  enum state
  {
    method_start,
    method,
    uri,
    http_version_h,
    http_version_t_1,
    http_version_t_2,
    http_version_p,
    http_version_slash,
    http_version_major_start,
    http_version_major,
    http_version_minor_start,
    http_version_minor,
    expecting_newline_1,
    header_line_start,
    header_lws,
    header_name,
    space_before_header_value,
    header_value,
    expecting_newline_2,
    expecting_newline_3
  } state_;
};

} // namespace server
} // namespace http

#endif // HTTP_REQUEST_PARSER_HPP