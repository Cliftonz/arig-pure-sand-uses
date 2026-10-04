local all_passed = true
for file in io.popen("ls tests/*_test.lua"):lines() do
  local passed = os.execute(arg[-1] .. " " .. file)
  print((passed and "PASS " or "FAIL ") .. file)
  all_passed = all_passed and passed
end
os.exit(all_passed == true)
