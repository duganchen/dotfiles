if has('mac')
	setlocal makeprg=/usr/local/opt/llvm/bin/clang-tidy\ %
	setlocal formatprg=/usr/local/opt/llvm/bin/clang-format\ %
end
