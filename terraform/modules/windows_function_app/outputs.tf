# In the module file where random_string.unique is declared
output "random_string_id" {
  value = random_string.unique.result
}