
f27:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

0000000000401176 <_Z1fPc>:
  401176:	f3 0f 1e fa          	endbr64 
  40117a:	55                   	push   %rbp
  40117b:	53                   	push   %rbx
  40117c:	48 83 ec 08          	sub    $0x8,%rsp
  401180:	48 89 fb             	mov    %rdi,%rbx
  401183:	be 2c 00 00 00       	mov    $0x2c,%esi
  401188:	e8 b3 fe ff ff       	callq  401040 <strchr@plt>
  40118d:	48 85 c0             	test   %rax,%rax
  401190:	74 49                	je     4011db <_Z1fPc+0x65>
  401192:	c6 00 00             	movb   $0x0,(%rax)
  401195:	48 8d 78 01          	lea    0x1(%rax),%rdi
  401199:	e8 d8 ff ff ff       	callq  401176 <_Z1fPc>
  40119e:	48 89 c5             	mov    %rax,%rbp
  4011a1:	48 89 c6             	mov    %rax,%rsi
  4011a4:	48 89 df             	mov    %rbx,%rdi
  4011a7:	e8 b4 fe ff ff       	callq  401060 <strcmp@plt>
  4011ac:	89 c2                	mov    %eax,%edx
  4011ae:	f7 d2                	not    %edx
  4011b0:	c1 ea 1f             	shr    $0x1f,%edx
  4011b3:	85 c0                	test   %eax,%eax
  4011b5:	0f 9f c0             	setg   %al
  4011b8:	0f b6 c0             	movzbl %al,%eax
  4011bb:	8d 4c 02 3c          	lea    0x3c(%rdx,%rax,1),%ecx
  4011bf:	49 89 e8             	mov    %rbp,%r8
  4011c2:	48 89 da             	mov    %rbx,%rdx
  4011c5:	48 8d 35 38 0e 00 00 	lea    0xe38(%rip),%rsi        # 402004 <_IO_stdin_used+0x4>
  4011cc:	bf 01 00 00 00       	mov    $0x1,%edi
  4011d1:	b8 00 00 00 00       	mov    $0x0,%eax
  4011d6:	e8 95 fe ff ff       	callq  401070 <__printf_chk@plt>
  4011db:	48 89 d8             	mov    %rbx,%rax
  4011de:	48 83 c4 08          	add    $0x8,%rsp
  4011e2:	5b                   	pop    %rbx
  4011e3:	5d                   	pop    %rbp
  4011e4:	c3                   	retq   

Disassembly of section .fini:
