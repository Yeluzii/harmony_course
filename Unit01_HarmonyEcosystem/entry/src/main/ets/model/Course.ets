/**
 * @file: Course.ets
 * @author: Yeluzii
 * @date: 2025/09/24
 */

export interface Course {
  name: string; // 课程名称
  teacher: string; // 教师
  time: string; // 时间
  location: string; // 地点
  type: string; // 课程类型
  day: number; // 星期几，1 - 7 分别代表周一到周日
}