
bomb:     file format elf64-x86-64


Disassembly of section .init:

0000000000400bb0 <_init>:
  400bb0:	48 83 ec 08          	sub    $0x8,%rsp
  400bb4:	48 8b 05 4d 27 20 00 	mov    0x20274d(%rip),%rax        # 603308 <__gmon_start__>
  400bbb:	48 85 c0             	test   %rax,%rax
  400bbe:	74 05                	je     400bc5 <_init+0x15>
  400bc0:	e8 4b 00 00 00       	callq  400c10 <__gmon_start__@plt>
  400bc5:	48 83 c4 08          	add    $0x8,%rsp
  400bc9:	c3                   	retq   

Disassembly of section .plt:

0000000000400bd0 <.plt>:
  400bd0:	ff 35 42 27 20 00    	pushq  0x202742(%rip)        # 603318 <_GLOBAL_OFFSET_TABLE_+0x8>
  400bd6:	ff 25 44 27 20 00    	jmpq   *0x202744(%rip)        # 603320 <_GLOBAL_OFFSET_TABLE_+0x10>
  400bdc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400be0 <printf@plt>:
  400be0:	ff 25 42 27 20 00    	jmpq   *0x202742(%rip)        # 603328 <printf@GLIBC_2.2.5>
  400be6:	68 00 00 00 00       	pushq  $0x0
  400beb:	e9 e0 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400bf0 <close@plt>:
  400bf0:	ff 25 3a 27 20 00    	jmpq   *0x20273a(%rip)        # 603330 <close@GLIBC_2.2.5>
  400bf6:	68 01 00 00 00       	pushq  $0x1
  400bfb:	e9 d0 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c00 <gethostbyname@plt>:
  400c00:	ff 25 32 27 20 00    	jmpq   *0x202732(%rip)        # 603338 <gethostbyname@GLIBC_2.2.5>
  400c06:	68 02 00 00 00       	pushq  $0x2
  400c0b:	e9 c0 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c10 <__gmon_start__@plt>:
  400c10:	ff 25 2a 27 20 00    	jmpq   *0x20272a(%rip)        # 603340 <__gmon_start__>
  400c16:	68 03 00 00 00       	pushq  $0x3
  400c1b:	e9 b0 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c20 <puts@plt>:
  400c20:	ff 25 22 27 20 00    	jmpq   *0x202722(%rip)        # 603348 <puts@GLIBC_2.2.5>
  400c26:	68 04 00 00 00       	pushq  $0x4
  400c2b:	e9 a0 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c30 <exit@plt>:
  400c30:	ff 25 1a 27 20 00    	jmpq   *0x20271a(%rip)        # 603350 <exit@GLIBC_2.2.5>
  400c36:	68 05 00 00 00       	pushq  $0x5
  400c3b:	e9 90 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c40 <__assert_fail@plt>:
  400c40:	ff 25 12 27 20 00    	jmpq   *0x202712(%rip)        # 603358 <__assert_fail@GLIBC_2.2.5>
  400c46:	68 06 00 00 00       	pushq  $0x6
  400c4b:	e9 80 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c50 <setvbuf@plt>:
  400c50:	ff 25 0a 27 20 00    	jmpq   *0x20270a(%rip)        # 603360 <setvbuf@GLIBC_2.2.5>
  400c56:	68 07 00 00 00       	pushq  $0x7
  400c5b:	e9 70 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c60 <read@plt>:
  400c60:	ff 25 02 27 20 00    	jmpq   *0x202702(%rip)        # 603368 <read@GLIBC_2.2.5>
  400c66:	68 08 00 00 00       	pushq  $0x8
  400c6b:	e9 60 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c70 <fopen@plt>:
  400c70:	ff 25 fa 26 20 00    	jmpq   *0x2026fa(%rip)        # 603370 <fopen@GLIBC_2.2.5>
  400c76:	68 09 00 00 00       	pushq  $0x9
  400c7b:	e9 50 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c80 <__libc_start_main@plt>:
  400c80:	ff 25 f2 26 20 00    	jmpq   *0x2026f2(%rip)        # 603378 <__libc_start_main@GLIBC_2.2.5>
  400c86:	68 0a 00 00 00       	pushq  $0xa
  400c8b:	e9 40 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400c90 <_exit@plt>:
  400c90:	ff 25 ea 26 20 00    	jmpq   *0x2026ea(%rip)        # 603380 <_exit@GLIBC_2.2.5>
  400c96:	68 0b 00 00 00       	pushq  $0xb
  400c9b:	e9 30 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400ca0 <__cxa_atexit@plt>:
  400ca0:	ff 25 e2 26 20 00    	jmpq   *0x2026e2(%rip)        # 603388 <__cxa_atexit@GLIBC_2.2.5>
  400ca6:	68 0c 00 00 00       	pushq  $0xc
  400cab:	e9 20 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400cb0 <fgets@plt>:
  400cb0:	ff 25 da 26 20 00    	jmpq   *0x2026da(%rip)        # 603390 <fgets@GLIBC_2.2.5>
  400cb6:	68 0d 00 00 00       	pushq  $0xd
  400cbb:	e9 10 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400cc0 <strlen@plt>:
  400cc0:	ff 25 d2 26 20 00    	jmpq   *0x2026d2(%rip)        # 603398 <strlen@GLIBC_2.2.5>
  400cc6:	68 0e 00 00 00       	pushq  $0xe
  400ccb:	e9 00 ff ff ff       	jmpq   400bd0 <.plt>

0000000000400cd0 <bcopy@plt>:
  400cd0:	ff 25 ca 26 20 00    	jmpq   *0x2026ca(%rip)        # 6033a0 <bcopy@GLIBC_2.2.5>
  400cd6:	68 0f 00 00 00       	pushq  $0xf
  400cdb:	e9 f0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400ce0 <sprintf@plt>:
  400ce0:	ff 25 c2 26 20 00    	jmpq   *0x2026c2(%rip)        # 6033a8 <sprintf@GLIBC_2.2.5>
  400ce6:	68 10 00 00 00       	pushq  $0x10
  400ceb:	e9 e0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400cf0 <sscanf@plt>:
  400cf0:	ff 25 ba 26 20 00    	jmpq   *0x2026ba(%rip)        # 6033b0 <sscanf@GLIBC_2.2.5>
  400cf6:	68 11 00 00 00       	pushq  $0x11
  400cfb:	e9 d0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d00 <sleep@plt>:
  400d00:	ff 25 b2 26 20 00    	jmpq   *0x2026b2(%rip)        # 6033b8 <sleep@GLIBC_2.2.5>
  400d06:	68 12 00 00 00       	pushq  $0x12
  400d0b:	e9 c0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d10 <strtol@plt>:
  400d10:	ff 25 aa 26 20 00    	jmpq   *0x2026aa(%rip)        # 6033c0 <strtol@GLIBC_2.2.5>
  400d16:	68 13 00 00 00       	pushq  $0x13
  400d1b:	e9 b0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d20 <connect@plt>:
  400d20:	ff 25 a2 26 20 00    	jmpq   *0x2026a2(%rip)        # 6033c8 <connect@GLIBC_2.2.5>
  400d26:	68 14 00 00 00       	pushq  $0x14
  400d2b:	e9 a0 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d30 <signal@plt>:
  400d30:	ff 25 9a 26 20 00    	jmpq   *0x20269a(%rip)        # 6033d0 <signal@GLIBC_2.2.5>
  400d36:	68 15 00 00 00       	pushq  $0x15
  400d3b:	e9 90 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d40 <socket@plt>:
  400d40:	ff 25 92 26 20 00    	jmpq   *0x202692(%rip)        # 6033d8 <socket@GLIBC_2.2.5>
  400d46:	68 16 00 00 00       	pushq  $0x16
  400d4b:	e9 80 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d50 <getenv@plt>:
  400d50:	ff 25 8a 26 20 00    	jmpq   *0x20268a(%rip)        # 6033e0 <getenv@GLIBC_2.2.5>
  400d56:	68 17 00 00 00       	pushq  $0x17
  400d5b:	e9 70 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d60 <alarm@plt>:
  400d60:	ff 25 82 26 20 00    	jmpq   *0x202682(%rip)        # 6033e8 <alarm@GLIBC_2.2.5>
  400d66:	68 18 00 00 00       	pushq  $0x18
  400d6b:	e9 60 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d70 <__errno_location@plt>:
  400d70:	ff 25 7a 26 20 00    	jmpq   *0x20267a(%rip)        # 6033f0 <__errno_location@GLIBC_2.2.5>
  400d76:	68 19 00 00 00       	pushq  $0x19
  400d7b:	e9 50 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d80 <strcmp@plt>:
  400d80:	ff 25 72 26 20 00    	jmpq   *0x202672(%rip)        # 6033f8 <strcmp@GLIBC_2.2.5>
  400d86:	68 1a 00 00 00       	pushq  $0x1a
  400d8b:	e9 40 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400d90 <strcpy@plt>:
  400d90:	ff 25 6a 26 20 00    	jmpq   *0x20266a(%rip)        # 603400 <strcpy@GLIBC_2.2.5>
  400d96:	68 1b 00 00 00       	pushq  $0x1b
  400d9b:	e9 30 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400da0 <memcmp@plt>:
  400da0:	ff 25 62 26 20 00    	jmpq   *0x202662(%rip)        # 603408 <memcmp@GLIBC_2.2.5>
  400da6:	68 1c 00 00 00       	pushq  $0x1c
  400dab:	e9 20 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400db0 <isspace@plt>:
  400db0:	ff 25 5a 26 20 00    	jmpq   *0x20265a(%rip)        # 603410 <isspace@GLIBC_2.2.5>
  400db6:	68 1d 00 00 00       	pushq  $0x1d
  400dbb:	e9 10 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400dc0 <isxdigit@plt>:
  400dc0:	ff 25 52 26 20 00    	jmpq   *0x202652(%rip)        # 603418 <isxdigit@GLIBC_2.2.5>
  400dc6:	68 1e 00 00 00       	pushq  $0x1e
  400dcb:	e9 00 fe ff ff       	jmpq   400bd0 <.plt>

0000000000400dd0 <fprintf@plt>:
  400dd0:	ff 25 4a 26 20 00    	jmpq   *0x20264a(%rip)        # 603420 <fprintf@GLIBC_2.2.5>
  400dd6:	68 1f 00 00 00       	pushq  $0x1f
  400ddb:	e9 f0 fd ff ff       	jmpq   400bd0 <.plt>

0000000000400de0 <write@plt>:
  400de0:	ff 25 42 26 20 00    	jmpq   *0x202642(%rip)        # 603428 <write@GLIBC_2.2.5>
  400de6:	68 20 00 00 00       	pushq  $0x20
  400deb:	e9 e0 fd ff ff       	jmpq   400bd0 <.plt>

Disassembly of section .text:

0000000000400df0 <main>:
  400df0:	55                   	push   %rbp
  400df1:	83 ff 02             	cmp    $0x2,%edi
  400df4:	48 89 e5             	mov    %rsp,%rbp
  400df7:	41 54                	push   %r12
  400df9:	53                   	push   %rbx
  400dfa:	48 89 f3             	mov    %rsi,%rbx
  400dfd:	0f 84 c4 00 00 00    	je     400ec7 <main+0xd7>
  400e03:	0f 8f 0f 01 00 00    	jg     400f18 <main+0x128>
  400e09:	e8 82 09 00 00       	callq  401790 <_Z15initialize_bombv>
  400e0e:	bf 6f 23 40 00       	mov    $0x40236f,%edi
  400e13:	e8 08 fe ff ff       	callq  400c20 <puts@plt>
  400e18:	e8 93 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400e1d:	48 89 c7             	mov    %rax,%rdi
  400e20:	e8 0b 02 00 00       	callq  401030 <_Z7phase_1Pc>
  400e25:	e8 96 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400e2a:	bf 7f 23 40 00       	mov    $0x40237f,%edi
  400e2f:	e8 ec fd ff ff       	callq  400c20 <puts@plt>
  400e34:	e8 77 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400e39:	48 89 c7             	mov    %rax,%rdi
  400e3c:	e8 0f 02 00 00       	callq  401050 <_Z7phase_2Pc>
  400e41:	e8 7a 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400e46:	bf 90 23 40 00       	mov    $0x402390,%edi
  400e4b:	e8 d0 fd ff ff       	callq  400c20 <puts@plt>
  400e50:	e8 5b 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400e55:	48 89 c7             	mov    %rax,%rdi
  400e58:	e8 43 02 00 00       	callq  4010a0 <_Z7phase_3Pc>
  400e5d:	e8 5e 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400e62:	bf a1 23 40 00       	mov    $0x4023a1,%edi
  400e67:	e8 b4 fd ff ff       	callq  400c20 <puts@plt>
  400e6c:	e8 3f 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400e71:	48 89 c7             	mov    %rax,%rdi
  400e74:	e8 a7 03 00 00       	callq  401220 <_Z7phase_4Pc>
  400e79:	e8 42 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400e7e:	bf b2 23 40 00       	mov    $0x4023b2,%edi
  400e83:	e8 98 fd ff ff       	callq  400c20 <puts@plt>
  400e88:	e8 23 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400e8d:	48 89 c7             	mov    %rax,%rdi
  400e90:	e8 3b 05 00 00       	callq  4013d0 <_Z7phase_5Pc>
  400e95:	e8 26 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400e9a:	bf c3 23 40 00       	mov    $0x4023c3,%edi
  400e9f:	e8 7c fd ff ff       	callq  400c20 <puts@plt>
  400ea4:	e8 07 0b 00 00       	callq  4019b0 <_Z9read_linev>
  400ea9:	48 89 c7             	mov    %rax,%rdi
  400eac:	e8 5f 05 00 00       	callq  401410 <_Z7phase_6Pc>
  400eb1:	e8 0a 0c 00 00       	callq  401ac0 <_Z13phase_defusedv>
  400eb6:	bf d4 23 40 00       	mov    $0x4023d4,%edi
  400ebb:	e8 60 fd ff ff       	callq  400c20 <puts@plt>
  400ec0:	5b                   	pop    %rbx
  400ec1:	31 c0                	xor    %eax,%eax
  400ec3:	41 5c                	pop    %r12
  400ec5:	5d                   	pop    %rbp
  400ec6:	c3                   	retq   
  400ec7:	4c 8b 66 08          	mov    0x8(%rsi),%r12
  400ecb:	be 3c 23 40 00       	mov    $0x40233c,%esi
  400ed0:	4c 89 e7             	mov    %r12,%rdi
  400ed3:	e8 a8 fe ff ff       	callq  400d80 <strcmp@plt>
  400ed8:	85 c0                	test   %eax,%eax
  400eda:	0f 84 29 ff ff ff    	je     400e09 <main+0x19>
  400ee0:	be 3e 23 40 00       	mov    $0x40233e,%esi
  400ee5:	4c 89 e7             	mov    %r12,%rdi
  400ee8:	e8 83 fd ff ff       	callq  400c70 <fopen@plt>
  400eed:	48 85 c0             	test   %rax,%rax
  400ef0:	48 89 05 e9 27 20 00 	mov    %rax,0x2027e9(%rip)        # 6036e0 <infile>
  400ef7:	0f 85 0c ff ff ff    	jne    400e09 <main+0x19>
  400efd:	48 8b 53 08          	mov    0x8(%rbx),%rdx
  400f01:	48 8b 33             	mov    (%rbx),%rsi
  400f04:	bf 40 23 40 00       	mov    $0x402340,%edi
  400f09:	e8 d2 fc ff ff       	callq  400be0 <printf@plt>
  400f0e:	bf 08 00 00 00       	mov    $0x8,%edi
  400f13:	e8 18 fd ff ff       	callq  400c30 <exit@plt>
  400f18:	48 8b 36             	mov    (%rsi),%rsi
  400f1b:	bf 5d 23 40 00       	mov    $0x40235d,%edi
  400f20:	31 c0                	xor    %eax,%eax
  400f22:	e8 b9 fc ff ff       	callq  400be0 <printf@plt>
  400f27:	bf 08 00 00 00       	mov    $0x8,%edi
  400f2c:	e8 ff fc ff ff       	callq  400c30 <exit@plt>
  400f31:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400f36:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  400f3d:	00 00 00 

0000000000400f40 <_GLOBAL__sub_I_infile>:
      400f40:	48 8b 05 79 27 20 00 	mov    0x202779(%rip),%rax        # 6036c0 <stdin@@GLIBC_2.2.5>
  400f47:	55                   	push   %rbp
  400f48:	48 89 e5             	mov    %rsp,%rbp
  400f4b:	48 89 05 8e 27 20 00 	mov    %rax,0x20278e(%rip)        # 6036e0 <infile>
  400f52:	5d                   	pop    %rbp
  400f53:	c3                   	retq   

0000000000400f54 <_start>:
  400f54:	31 ed                	xor    %ebp,%ebp
  400f56:	49 89 d1             	mov    %rdx,%r9
  400f59:	5e                   	pop    %rsi
  400f5a:	48 89 e2             	mov    %rsp,%rdx
  400f5d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400f61:	50                   	push   %rax
  400f62:	54                   	push   %rsp
  400f63:	49 c7 c0 00 23 40 00 	mov    $0x402300,%r8
  400f6a:	48 c7 c1 90 22 40 00 	mov    $0x402290,%rcx
  400f71:	48 c7 c7 f0 0d 40 00 	mov    $0x400df0,%rdi
  400f78:	e8 03 fd ff ff       	callq  400c80 <__libc_start_main@plt>
  400f7d:	f4                   	hlt    
  400f7e:	66 90                	xchg   %ax,%ax

0000000000400f80 <deregister_tm_clones>:
  400f80:	55                   	push   %rbp
  400f81:	b8 a8 36 60 00       	mov    $0x6036a8,%eax
  400f86:	48 3d a8 36 60 00    	cmp    $0x6036a8,%rax
  400f8c:	48 89 e5             	mov    %rsp,%rbp
  400f8f:	74 17                	je     400fa8 <deregister_tm_clones+0x28>
  400f91:	b8 00 00 00 00       	mov    $0x0,%eax
  400f96:	48 85 c0             	test   %rax,%rax
  400f99:	74 0d                	je     400fa8 <deregister_tm_clones+0x28>
  400f9b:	5d                   	pop    %rbp
  400f9c:	bf a8 36 60 00       	mov    $0x6036a8,%edi
  400fa1:	ff e0                	jmpq   *%rax
  400fa3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400fa8:	5d                   	pop    %rbp
  400fa9:	c3                   	retq   
  400faa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400fb0 <register_tm_clones>:
  400fb0:	be a8 36 60 00       	mov    $0x6036a8,%esi
  400fb5:	55                   	push   %rbp
  400fb6:	48 81 ee a8 36 60 00 	sub    $0x6036a8,%rsi
  400fbd:	48 89 e5             	mov    %rsp,%rbp
  400fc0:	48 c1 fe 03          	sar    $0x3,%rsi
  400fc4:	48 89 f0             	mov    %rsi,%rax
  400fc7:	48 c1 e8 3f          	shr    $0x3f,%rax
  400fcb:	48 01 c6             	add    %rax,%rsi
  400fce:	48 d1 fe             	sar    %rsi
  400fd1:	74 15                	je     400fe8 <register_tm_clones+0x38>
  400fd3:	b8 00 00 00 00       	mov    $0x0,%eax
  400fd8:	48 85 c0             	test   %rax,%rax
  400fdb:	74 0b                	je     400fe8 <register_tm_clones+0x38>
  400fdd:	5d                   	pop    %rbp
  400fde:	bf a8 36 60 00       	mov    $0x6036a8,%edi
  400fe3:	ff e0                	jmpq   *%rax
  400fe5:	0f 1f 00             	nopl   (%rax)
  400fe8:	5d                   	pop    %rbp
  400fe9:	c3                   	retq   
  400fea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400ff0 <__do_global_dtors_aux>:
  400ff0:	80 3d e1 26 20 00 00 	cmpb   $0x0,0x2026e1(%rip)        # 6036d8 <completed.6940>
  400ff7:	75 17                	jne    401010 <__do_global_dtors_aux+0x20>
  400ff9:	55                   	push   %rbp
  400ffa:	48 89 e5             	mov    %rsp,%rbp
  400ffd:	e8 7e ff ff ff       	callq  400f80 <deregister_tm_clones>
  401002:	c6 05 cf 26 20 00 01 	movb   $0x1,0x2026cf(%rip)        # 6036d8 <completed.6940>
  401009:	5d                   	pop    %rbp
  40100a:	c3                   	retq   
  40100b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401010:	f3 c3                	repz retq 
  401012:	0f 1f 40 00          	nopl   0x0(%rax)
  401016:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40101d:	00 00 00 

0000000000401020 <frame_dummy>:
  401020:	55                   	push   %rbp
  401021:	48 89 e5             	mov    %rsp,%rbp
  401024:	5d                   	pop    %rbp
  401025:	eb 89                	jmp    400fb0 <register_tm_clones>
  401027:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40102e:	00 00 

0000000000401030 <_Z7phase_1Pc>:
  401030:	55                   	push   %rbp
  401031:	be e5 23 40 00       	mov    $0x4023e5,%esi
  401036:	48 89 e5             	mov    %rsp,%rbp
  401039:	e8 42 fd ff ff       	callq  400d80 <strcmp@plt>
  40103e:	85 c0                	test   %eax,%eax
  401040:	75 02                	jne    401044 <_Z7phase_1Pc+0x14>
  401042:	5d                   	pop    %rbp
  401043:	c3                   	retq   
  401044:	e8 e7 08 00 00       	callq  401930 <_Z12explode_bombv>
  401049:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000401050 <_Z7phase_2Pc>:
  401050:	55                   	push   %rbp
  401051:	48 89 e5             	mov    %rsp,%rbp
  401054:	48 83 ec 20          	sub    $0x20,%rsp
  401058:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
  40105c:	e8 0f 09 00 00       	callq  401970 <_Z16read_six_numbersPKcPi>
  401061:	8b 55 e0             	mov    -0x20(%rbp),%edx
  401064:	85 d2                	test   %edx,%edx
  401066:	78 25                	js     40108d <_Z7phase_2Pc+0x3d>
  401068:	b8 01 00 00 00       	mov    $0x1,%eax
  40106d:	8b 4c 85 e0          	mov    -0x20(%rbp,%rax,4),%ecx
  401071:	01 c2                	add    %eax,%edx
  401073:	39 d1                	cmp    %edx,%ecx
  401075:	75 16                	jne    40108d <_Z7phase_2Pc+0x3d>
  401077:	48 83 f8 05          	cmp    $0x5,%rax
  40107b:	74 1b                	je     401098 <_Z7phase_2Pc+0x48>
  40107d:	48 83 c0 01          	add    $0x1,%rax
  401081:	89 ca                	mov    %ecx,%edx
  401083:	8b 4c 85 e0          	mov    -0x20(%rbp,%rax,4),%ecx
  401087:	01 c2                	add    %eax,%edx
  401089:	39 d1                	cmp    %edx,%ecx
  40108b:	74 ea                	je     401077 <_Z7phase_2Pc+0x27>
  40108d:	e8 9e 08 00 00       	callq  401930 <_Z12explode_bombv>
  401092:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401098:	c9                   	leaveq 
  401099:	c3                   	retq   
  40109a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004010a0 <_Z7phase_3Pc>:
  4010a0:	55                   	push   %rbp
  4010a1:	31 c0                	xor    %eax,%eax
  4010a3:	be a0 26 40 00       	mov    $0x4026a0,%esi
  4010a8:	48 89 e5             	mov    %rsp,%rbp
  4010ab:	48 83 ec 10          	sub    $0x10,%rsp
  4010af:	4c 8d 45 fc          	lea    -0x4(%rbp),%r8
  4010b3:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
  4010b7:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
  4010bb:	e8 30 fc ff ff       	callq  400cf0 <sscanf@plt>
  4010c0:	83 f8 02             	cmp    $0x2,%eax
  4010c3:	7e 6b                	jle    401130 <_Z7phase_3Pc+0x90>
  4010c5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  4010c8:	83 f8 05             	cmp    $0x5,%eax
  4010cb:	77 63                	ja     401130 <_Z7phase_3Pc+0x90>
  4010cd:	89 c2                	mov    %eax,%edx
  4010cf:	ff 24 d5 28 24 40 00 	jmpq   *0x402428(,%rdx,8)
  4010d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4010dd:	00 00 00 
  4010e0:	ba 6d ff ff ff       	mov    $0xffffff6d,%edx
  4010e5:	83 f8 05             	cmp    $0x5,%eax
  4010e8:	7f 46                	jg     401130 <_Z7phase_3Pc+0x90>
  4010ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4010ed:	03 45 f8             	add    -0x8(%rbp),%eax
  4010f0:	39 d0                	cmp    %edx,%eax
  4010f2:	75 3c                	jne    401130 <_Z7phase_3Pc+0x90>
  4010f4:	c9                   	leaveq 
  4010f5:	c3                   	retq   
  4010f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4010fd:	00 00 00 
  401100:	31 d2                	xor    %edx,%edx
  401102:	eb e1                	jmp    4010e5 <_Z7phase_3Pc+0x45>
  401104:	0f 1f 40 00          	nopl   0x0(%rax)
  401108:	ba 8b 02 00 00       	mov    $0x28b,%edx
  40110d:	eb d6                	jmp    4010e5 <_Z7phase_3Pc+0x45>
  40110f:	90                   	nop
  401110:	ba 16 02 00 00       	mov    $0x216,%edx
  401115:	eb ce                	jmp    4010e5 <_Z7phase_3Pc+0x45>
  401117:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40111e:	00 00 
  401120:	ba 09 ff ff ff       	mov    $0xffffff09,%edx
  401125:	eb be                	jmp    4010e5 <_Z7phase_3Pc+0x45>
  401127:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40112e:	00 00 
  401130:	e8 fb 07 00 00       	callq  401930 <_Z12explode_bombv>
  401135:	90                   	nop
  401136:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40113d:	00 00 00 

0000000000401140 <_Z4playPKcPcS1_>:
  401140:	55                   	push   %rbp
  401141:	48 89 e5             	mov    %rsp,%rbp
  401144:	41 56                	push   %r14
  401146:	41 55                	push   %r13
  401148:	41 54                	push   %r12
  40114a:	53                   	push   %rbx
  40114b:	48 89 f3             	mov    %rsi,%rbx
  40114e:	49 89 fe             	mov    %rdi,%r14
  401151:	49 89 d4             	mov    %rdx,%r12
  401154:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  40115b:	e8 60 fb ff ff       	callq  400cc0 <strlen@plt> # 5
  401160:	48 89 df             	mov    %rbx,%rdi
  401163:	49 89 c5             	mov    %rax,%r13
  401166:	e8 55 fb ff ff       	callq  400cc0 <strlen@plt> # length of second part, which must be longer
  40116b:	49 39 c5             	cmp    %rax,%r13
  40116e:	0f 83 a1 00 00 00    	jae    401215 <_Z4playPKcPcS1_+0xd5>
  401174:	4c 89 ea             	mov    %r13,%rdx           # use smaller length for memcmp
  401177:	48 89 de             	mov    %rbx,%rsi
  40117a:	4c 89 f7             	mov    %r14,%rdi
  40117d:	e8 1e fc ff ff       	callq  400da0 <memcmp@plt>
  401182:	85 c0                	test   %eax,%eax
  401184:	0f 85 8b 00 00 00    	jne    401215 <_Z4playPKcPcS1_+0xd5>        # Ensure both strings have equal length
  40118a:	4d 85 ed             	test   %r13,%r13 # 5
  40118d:	4e 8d 34 2b          	lea    (%rbx,%r13,1),%r14           # second part + 5 -> store in r14
  401191:	74 0d                	je     4011a0 <_Z4playPKcPcS1_+0x60>
  401193:	41 0f b6 3e          	movzbl (%r14),%edi                  # store the byte at second part + 5 in rdi
  401197:	e8 14 fc ff ff       	callq  400db0 <isspace@plt>         # the byte at second part + 5 must be space
  40119c:	85 c0                	test   %eax,%eax
  40119e:	74 75                	je     401215 <_Z4playPKcPcS1_+0xd5>
  4011a0:	48 8d 8d 3c ff ff ff 	lea    -0xc4(%rbp),%rcx      # address at which number of sscanf'ed bytes is stored
  4011a7:	31 c0                	xor    %eax,%eax
  4011a9:	4c 89 e2             	mov    %r12,%rdx             # beginning of the 176 bytes
  4011ac:	be fc 23 40 00       	mov    $0x4023fc,%esi        #  %[a-z]%n
  4011b1:	4c 89 f7             	mov    %r14,%rdi             # second part + 5
  4011b4:	e8 37 fb ff ff       	callq  400cf0 <sscanf@plt>
  4011b9:	83 f8 01             	cmp    $0x1,%eax             # sscanf should only set 1 string (at r12's address)
  4011bc:	75 57                	jne    401215 <_Z4playPKcPcS1_+0xd5>
  4011be:	48 63 b5 3c ff ff ff 	movslq -0xc4(%rbp),%rsi      # address at which number of sscanf'ed bytes is stored
  4011c5:	4c 01 ee             	add    %r13,%rsi             # adds strlen of first string (here empty) to num bytes
  4011c8:	48 01 de             	add    %rbx,%rsi             # rsi now points to just after what was read
  4011cb:	0f b6 16             	movzbl (%rsi),%edx           # moves the next byte after what was read into edx
  4011ce:	84 d2                	test   %dl,%dl               # If next byte was null byte, return (bad if rax < 5)
  4011d0:	74 33                	je     401205 <_Z4playPKcPcS1_+0xc5>
  4011d2:	80 fa 2c             	cmp    $0x2c,%dl             # If the next byte was not comma, explode (always bad)
  4011d5:	75 3e                	jne    401215 <_Z4playPKcPcS1_+0xd5>
  4011d7:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
  4011de:	c6 06 00             	movb   $0x0,(%rsi)           # Replace comma with null byte
  4011e1:	48 89 df             	mov    %rbx,%rdi             # Beginning of input string
  4011e4:	48 83 c6 01          	add    $0x1,%rsi             # rsi points to after the null byte
  4011e8:	e8 53 ff ff ff       	callq  401140 <_Z4playPKcPcS1_>        # Recurse with input string, pointer to just after "peach,", and pointer
  4011ed:	48 8d bd 40 ff ff ff 	lea    -0xc0(%rbp),%rdi
  4011f4:	4c 89 e6             	mov    %r12,%rsi
  4011f7:	89 c3                	mov    %eax,%ebx
  4011f9:	e8 82 fb ff ff       	callq  400d80 <strcmp@plt>
  4011fe:	85 c0                	test   %eax,%eax
  401200:	7e 13                	jle    401215 <_Z4playPKcPcS1_+0xd5>
  401202:	8d 43 01             	lea    0x1(%rbx),%eax
  401205:	48 81 c4 b0 00 00 00 	add    $0xb0,%rsp
  40120c:	5b                   	pop    %rbx
  40120d:	41 5c                	pop    %r12
  40120f:	41 5d                	pop    %r13
  401211:	41 5e                	pop    %r14
  401213:	5d                   	pop    %rbp
  401214:	c3                   	retq   
  401215:	e8 16 07 00 00       	callq  401930 <_Z12explode_bombv>
  40121a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000401220 <_Z7phase_4Pc>:
  401220:	55                   	push   %rbp
  401221:	48 89 fe             	mov    %rdi,%rsi
  401224:	bf da 29 40 00       	mov    $0x4029da,%edi        # empty string
  401229:	48 89 e5             	mov    %rsp,%rbp
  40122c:	53                   	push   %rbx
  40122d:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
  401234:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
  40123b:	e8 00 ff ff ff       	callq  401140 <_Z4playPKcPcS1_>        # args are empty string, input string, pointer to 176 bytes of memory
  401240:	48 8d bd 50 ff ff ff 	lea    -0xb0(%rbp),%rdi
  401247:	89 c3                	mov    %eax,%ebx
  401249:	be 06 24 40 00       	mov    $0x402406,%esi        # peach
  40124e:	e8 2d fb ff ff       	callq  400d80 <strcmp@plt>
  401253:	83 fb 04             	cmp    $0x4,%ebx             # value returned by play must be >4
  401256:	7e 0e                	jle    401266 <_Z7phase_4Pc+0x46>
  401258:	85 c0                	test   %eax,%eax             # rdi value must point to peach
  40125a:	75 0a                	jne    401266 <_Z7phase_4Pc+0x46>
  40125c:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
  401263:	5b                   	pop    %rbx
  401264:	5d                   	pop    %rbp
  401265:	c3                   	retq   
  401266:	e8 c5 06 00 00       	callq  401930 <_Z12explode_bombv>
  40126b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000401270 <_Z10calculatorPc>:
  401270:	55                   	push   %rbp
  401271:	48 89 e5             	mov    %rsp,%rbp
  401274:	41 57                	push   %r15
  401276:	41 56                	push   %r14
  401278:	41 55                	push   %r13
  40127a:	41 54                	push   %r12
  40127c:	4c 8d a5 30 ff ff ff 	lea    -0xd0(%rbp),%r12
  401283:	53                   	push   %rbx
  401284:	49 89 fd             	mov    %rdi,%r13
  401287:	4d 8d 7c 24 08       	lea    0x8(%r12),%r15
  40128c:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
  401293:	41 0f b6 5d 00       	movzbl 0x0(%r13),%ebx
  401298:	84 db                	test   %bl,%bl
  40129a:	74 62                	je     4012fe <_Z10calculatorPc+0x8e>
  40129c:	44 0f b6 f3          	movzbl %bl,%r14d
  4012a0:	44 89 f7             	mov    %r14d,%edi
  4012a3:	e8 18 fb ff ff       	callq  400dc0 <isxdigit@plt>
  4012a8:	85 c0                	test   %eax,%eax
  4012aa:	74 74                	je     401320 <_Z10calculatorPc+0xb0>
  4012ac:	80 fb 30             	cmp    $0x30,%bl
  4012af:	74 6f                	je     401320 <_Z10calculatorPc+0xb0>
  4012b1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  4012b5:	49 39 c4             	cmp    %rax,%r12
  4012b8:	0f 84 c2 00 00 00    	je     401380 <_Z10calculatorPc+0x110>
  4012be:	48 8d 8d 2c ff ff ff 	lea    -0xd4(%rbp),%rcx
  4012c5:	48 8d 95 2a ff ff ff 	lea    -0xd6(%rbp),%rdx
  4012cc:	4c 89 ef             	mov    %r13,%rdi
  4012cf:	31 c0                	xor    %eax,%eax
  4012d1:	be 0c 24 40 00       	mov    $0x40240c,%esi
  4012d6:	49 83 c4 04          	add    $0x4,%r12
  4012da:	e8 11 fa ff ff       	callq  400cf0 <sscanf@plt>
  4012df:	0f b7 85 2a ff ff ff 	movzwl -0xd6(%rbp),%eax
  4012e6:	41 89 44 24 fc       	mov    %eax,-0x4(%r12)
  4012eb:	48 63 85 2c ff ff ff 	movslq -0xd4(%rbp),%rax
  4012f2:	49 01 c5             	add    %rax,%r13
  4012f5:	41 0f b6 5d 00       	movzbl 0x0(%r13),%ebx
  4012fa:	84 db                	test   %bl,%bl
  4012fc:	75 9e                	jne    40129c <_Z10calculatorPc+0x2c>
  4012fe:	48 8d 85 30 ff ff ff 	lea    -0xd0(%rbp),%rax
  401305:	48 8d 50 04          	lea    0x4(%rax),%rdx
  401309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40130e:	49 39 d4             	cmp    %rdx,%r12
  401311:	75 72                	jne    401385 <_Z10calculatorPc+0x115>
  401313:	8b 85 30 ff ff ff    	mov    -0xd0(%rbp),%eax
  401319:	eb 6a                	jmp    401385 <_Z10calculatorPc+0x115>
  40131b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401320:	80 fb 3c             	cmp    $0x3c,%bl
  401323:	74 23                	je     401348 <_Z10calculatorPc+0xd8>
  401325:	80 fb 7c             	cmp    $0x7c,%bl
  401328:	74 3e                	je     401368 <_Z10calculatorPc+0xf8>
  40132a:	80 fb 25             	cmp    $0x25,%bl
  40132d:	74 71                	je     4013a0 <_Z10calculatorPc+0x130>
  40132f:	44 89 f7             	mov    %r14d,%edi
  401332:	e8 79 fa ff ff       	callq  400db0 <isspace@plt>
  401337:	85 c0                	test   %eax,%eax
  401339:	74 45                	je     401380 <_Z10calculatorPc+0x110>
  40133b:	49 83 c5 01          	add    $0x1,%r13
  40133f:	e9 4f ff ff ff       	jmpq   401293 <_Z10calculatorPc+0x23>
  401344:	0f 1f 40 00          	nopl   0x0(%rax)
  401348:	4d 39 fc             	cmp    %r15,%r12
  40134b:	72 33                	jb     401380 <_Z10calculatorPc+0x110>
  40134d:	41 8b 4c 24 fc       	mov    -0x4(%r12),%ecx
  401352:	83 f9 1f             	cmp    $0x1f,%ecx
  401355:	77 29                	ja     401380 <_Z10calculatorPc+0x110>
  401357:	41 d3 44 24 f8       	roll   %cl,-0x8(%r12)
  40135c:	49 83 ec 04          	sub    $0x4,%r12
  401360:	eb d9                	jmp    40133b <_Z10calculatorPc+0xcb>
  401362:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401368:	4d 39 fc             	cmp    %r15,%r12
  40136b:	72 13                	jb     401380 <_Z10calculatorPc+0x110>
  40136d:	41 8b 44 24 fc       	mov    -0x4(%r12),%eax
  401372:	41 09 44 24 f8       	or     %eax,-0x8(%r12)
  401377:	49 83 ec 04          	sub    $0x4,%r12
  40137b:	eb be                	jmp    40133b <_Z10calculatorPc+0xcb>
  40137d:	0f 1f 00             	nopl   (%rax)
  401380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401385:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
  40138c:	5b                   	pop    %rbx
  40138d:	41 5c                	pop    %r12
  40138f:	41 5d                	pop    %r13
  401391:	41 5e                	pop    %r14
  401393:	41 5f                	pop    %r15
  401395:	5d                   	pop    %rbp
  401396:	c3                   	retq   
  401397:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40139e:	00 00 
  4013a0:	4d 39 fc             	cmp    %r15,%r12
  4013a3:	72 db                	jb     401380 <_Z10calculatorPc+0x110>
  4013a5:	41 8b 4c 24 fc       	mov    -0x4(%r12),%ecx
  4013aa:	85 c9                	test   %ecx,%ecx
  4013ac:	74 d2                	je     401380 <_Z10calculatorPc+0x110>
  4013ae:	41 8b 44 24 f8       	mov    -0x8(%r12),%eax
  4013b3:	31 d2                	xor    %edx,%edx
  4013b5:	49 83 ec 04          	sub    $0x4,%r12
  4013b9:	f7 f1                	div    %ecx
  4013bb:	41 89 54 24 fc       	mov    %edx,-0x4(%r12)
  4013c0:	e9 76 ff ff ff       	jmpq   40133b <_Z10calculatorPc+0xcb>
  4013c5:	90                   	nop
  4013c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4013cd:	00 00 00 

00000000004013d0 <_Z7phase_5Pc>:
  4013d0:	55                   	push   %rbp
  4013d1:	48 89 e5             	mov    %rsp,%rbp
  4013d4:	53                   	push   %rbx
  4013d5:	48 83 ec 08          	sub    $0x8,%rsp
  4013d9:	e8 92 fe ff ff       	callq  401270 <_Z10calculatorPc>
  4013de:	bf 12 24 40 00       	mov    $0x402412,%edi
  4013e3:	89 c3                	mov    %eax,%ebx
  4013e5:	89 c6                	mov    %eax,%esi
  4013e7:	31 c0                	xor    %eax,%eax
  4013e9:	e8 f2 f7 ff ff       	callq  400be0 <printf@plt>
  4013ee:	81 fb 93 4f ae 7e    	cmp    $0x7eae4f93,%ebx
  4013f4:	75 07                	jne    4013fd <_Z7phase_5Pc+0x2d>
  4013f6:	48 83 c4 08          	add    $0x8,%rsp
  4013fa:	5b                   	pop    %rbx
  4013fb:	5d                   	pop    %rbp
  4013fc:	c3                   	retq   
  4013fd:	e8 2e 05 00 00       	callq  401930 <_Z12explode_bombv>
  401402:	0f 1f 40 00          	nopl   0x0(%rax)
  401406:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40140d:	00 00 00 

0000000000401410 <_Z7phase_6Pc>:
  401410:	55                   	push   %rbp
  401411:	48 89 e5             	mov    %rsp,%rbp
  401414:	48 83 ec 50          	sub    $0x50,%rsp
  401418:	48 8d 75 b0          	lea    -0x50(%rbp),%rsi
  40141c:	e8 4f 05 00 00       	callq  401970 <_Z16read_six_numbersPKcPi>
  401421:	8b 55 b0             	mov    -0x50(%rbp),%edx
  401424:	b9 02 00 00 00       	mov    $0x2,%ecx
  401429:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401430:	8d 42 ff             	lea    -0x1(%rdx),%eax
  401433:	83 f8 05             	cmp    $0x5,%eax
  401436:	0f 87 fe 00 00 00    	ja     40153a <_Z7phase_6Pc+0x12a>
  40143c:	48 83 f9 07          	cmp    $0x7,%rcx
  401440:	74 31                	je     401473 <_Z7phase_6Pc+0x63>
  401442:	8b 74 8d ac          	mov    -0x54(%rbp,%rcx,4),%esi
  401446:	39 d6                	cmp    %edx,%esi
  401448:	0f 84 ec 00 00 00    	je     40153a <_Z7phase_6Pc+0x12a>
  40144e:	48 89 c8             	mov    %rcx,%rax
  401451:	eb 13                	jmp    401466 <_Z7phase_6Pc+0x56>
  401453:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401458:	48 83 c0 01          	add    $0x1,%rax
  40145c:	39 54 85 ac          	cmp    %edx,-0x54(%rbp,%rax,4)
  401460:	0f 84 d4 00 00 00    	je     40153a <_Z7phase_6Pc+0x12a>
  401466:	83 f8 06             	cmp    $0x6,%eax
  401469:	75 ed                	jne    401458 <_Z7phase_6Pc+0x48>
  40146b:	48 83 c1 01          	add    $0x1,%rcx
  40146f:	89 f2                	mov    %esi,%edx
  401471:	eb bd                	jmp    401430 <_Z7phase_6Pc+0x20>
  401473:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
  401477:	b9 07 00 00 00       	mov    $0x7,%ecx
  40147c:	48 8d 70 18          	lea    0x18(%rax),%rsi
  401480:	89 ca                	mov    %ecx,%edx
  401482:	2b 10                	sub    (%rax),%edx
  401484:	48 83 c0 04          	add    $0x4,%rax
  401488:	89 50 fc             	mov    %edx,-0x4(%rax)
  40148b:	48 39 f0             	cmp    %rsi,%rax
  40148e:	75 f0                	jne    401480 <_Z7phase_6Pc+0x70>
  401490:	31 f6                	xor    %esi,%esi
  401492:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401498:	8b 4c b5 b0          	mov    -0x50(%rbp,%rsi,4),%ecx
  40149c:	83 f9 01             	cmp    $0x1,%ecx
  40149f:	7e 7f                	jle    401520 <_Z7phase_6Pc+0x110>
  4014a1:	b8 01 00 00 00       	mov    $0x1,%eax
  4014a6:	ba 20 36 60 00       	mov    $0x603620,%edx
  4014ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4014b0:	83 c0 01             	add    $0x1,%eax
  4014b3:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  4014b7:	39 c8                	cmp    %ecx,%eax
  4014b9:	75 f5                	jne    4014b0 <_Z7phase_6Pc+0xa0>
  4014bb:	48 89 54 f5 d0       	mov    %rdx,-0x30(%rbp,%rsi,8)
  4014c0:	48 83 c6 01          	add    $0x1,%rsi
  4014c4:	48 83 fe 06          	cmp    $0x6,%rsi
  4014c8:	75 ce                	jne    401498 <_Z7phase_6Pc+0x88>
  4014ca:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  4014ce:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
  4014d2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  4014d6:	48 89 50 08          	mov    %rdx,0x8(%rax)
  4014da:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4014de:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
  4014e2:	8b 30                	mov    (%rax),%esi
  4014e4:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  4014e8:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
  4014ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4014f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  4014f4:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  4014f8:	48 c7 42 08 00 00 00 	movq   $0x0,0x8(%rdx)
  4014ff:	00 
  401500:	ba 05 00 00 00       	mov    $0x5,%edx
  401505:	48 8b 40 08          	mov    0x8(%rax),%rax
  401509:	8b 08                	mov    (%rax),%ecx
  40150b:	39 f1                	cmp    %esi,%ecx
  40150d:	7f 2b                	jg     40153a <_Z7phase_6Pc+0x12a>
  40150f:	83 ea 01             	sub    $0x1,%edx
  401512:	89 ce                	mov    %ecx,%esi
  401514:	75 ef                	jne    401505 <_Z7phase_6Pc+0xf5>
  401516:	c9                   	leaveq 
  401517:	c3                   	retq   
  401518:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40151f:	00 
  401520:	ba 20 36 60 00       	mov    $0x603620,%edx
  401525:	48 89 54 f5 d0       	mov    %rdx,-0x30(%rbp,%rsi,8)
  40152a:	48 83 c6 01          	add    $0x1,%rsi
  40152e:	48 83 fe 06          	cmp    $0x6,%rsi
  401532:	0f 85 60 ff ff ff    	jne    401498 <_Z7phase_6Pc+0x88>
  401538:	eb 90                	jmp    4014ca <_Z7phase_6Pc+0xba>
  40153a:	e8 f1 03 00 00       	callq  401930 <_Z12explode_bombv>
  40153f:	90                   	nop

0000000000401540 <_Z4fun7P14treeNodeStructi>:
  401540:	48 85 ff             	test   %rdi,%rdi
  401543:	74 38                	je     40157d <_Z4fun7P14treeNodeStructi+0x3d>
  401545:	55                   	push   %rbp
  401546:	39 37                	cmp    %esi,(%rdi)
  401548:	48 89 e5             	mov    %rsp,%rbp
  40154b:	7f 23                	jg     401570 <_Z4fun7P14treeNodeStructi+0x30>
  40154d:	b8 00 00 00 00       	mov    $0x0,%eax
  401552:	75 0c                	jne    401560 <_Z4fun7P14treeNodeStructi+0x20>
  401554:	5d                   	pop    %rbp
  401555:	c3                   	retq   
  401556:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40155d:	00 00 00 
  401560:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
  401564:	e8 d7 ff ff ff       	callq  401540 <_Z4fun7P14treeNodeStructi>
  401569:	5d                   	pop    %rbp
  40156a:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  40156e:	c3                   	retq   
  40156f:	90                   	nop
  401570:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
  401574:	e8 c7 ff ff ff       	callq  401540 <_Z4fun7P14treeNodeStructi>
  401579:	5d                   	pop    %rbp
  40157a:	01 c0                	add    %eax,%eax
  40157c:	c3                   	retq   
  40157d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401582:	c3                   	retq   
  401583:	0f 1f 00             	nopl   (%rax)
  401586:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40158d:	00 00 00 

0000000000401590 <_Z12secret_phasev>:
  401590:	55                   	push   %rbp
  401591:	48 89 e5             	mov    %rsp,%rbp
  401594:	e8 17 04 00 00       	callq  4019b0 <_Z9read_linev>
  401599:	ba 0a 00 00 00       	mov    $0xa,%edx
  40159e:	31 f6                	xor    %esi,%esi
  4015a0:	48 89 c7             	mov    %rax,%rdi
  4015a3:	e8 68 f7 ff ff       	callq  400d10 <strtol@plt>
  4015a8:	8d 50 ff             	lea    -0x1(%rax),%edx
  4015ab:	81 fa e8 03 00 00    	cmp    $0x3e8,%edx
  4015b1:	77 21                	ja     4015d4 <_Z12secret_phasev+0x44>
  4015b3:	89 c6                	mov    %eax,%esi
  4015b5:	bf 40 34 60 00       	mov    $0x603440,%edi
  4015ba:	e8 81 ff ff ff       	callq  401540 <_Z4fun7P14treeNodeStructi>
  4015bf:	83 f8 01             	cmp    $0x1,%eax
  4015c2:	75 10                	jne    4015d4 <_Z12secret_phasev+0x44>
  4015c4:	bf 58 24 40 00       	mov    $0x402458,%edi
  4015c9:	e8 52 f6 ff ff       	callq  400c20 <puts@plt>
  4015ce:	5d                   	pop    %rbp
  4015cf:	e9 ec 04 00 00       	jmpq   401ac0 <_Z13phase_defusedv>
  4015d4:	e8 57 03 00 00       	callq  401930 <_Z12explode_bombv>
  4015d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004015e0 <_ZL11sig_handleri>:
  4015e0:	55                   	push   %rbp
  4015e1:	ba 39 00 00 00       	mov    $0x39,%edx
  4015e6:	be 80 24 40 00       	mov    $0x402480,%esi
  4015eb:	bf 01 00 00 00       	mov    $0x1,%edi
  4015f0:	48 89 e5             	mov    %rsp,%rbp
  4015f3:	e8 e8 f7 ff ff       	callq  400de0 <write@plt>
  4015f8:	bf 03 00 00 00       	mov    $0x3,%edi
  4015fd:	e8 fe f6 ff ff       	callq  400d00 <sleep@plt>
  401602:	ba 07 00 00 00       	mov    $0x7,%edx
  401607:	be fb 25 40 00       	mov    $0x4025fb,%esi
  40160c:	bf 01 00 00 00       	mov    $0x1,%edi
  401611:	e8 ca f7 ff ff       	callq  400de0 <write@plt>
  401616:	bf 01 00 00 00       	mov    $0x1,%edi
  40161b:	e8 e0 f6 ff ff       	callq  400d00 <sleep@plt>
  401620:	bf 01 00 00 00       	mov    $0x1,%edi
  401625:	ba 08 00 00 00       	mov    $0x8,%edx
  40162a:	be 03 26 40 00       	mov    $0x402603,%esi
  40162f:	e8 ac f7 ff ff       	callq  400de0 <write@plt>
  401634:	bf 10 00 00 00       	mov    $0x10,%edi
  401639:	e8 52 f6 ff ff       	callq  400c90 <_exit@plt>
  40163e:	66 90                	xchg   %ax,%ax

0000000000401640 <_Z1ev.part.0>:
  401640:	55                   	push   %rbp
  401641:	31 c0                	xor    %eax,%eax
  401643:	be 0c 26 40 00       	mov    $0x40260c,%esi
  401648:	bf 60 38 60 00       	mov    $0x603860,%edi
  40164d:	48 89 e5             	mov    %rsp,%rbp
  401650:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
  401657:	4c 8d 85 c0 fe ff ff 	lea    -0x140(%rbp),%r8
  40165e:	4c 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%r9
  401665:	4c 89 c1             	mov    %r8,%rcx
  401668:	4c 89 c2             	mov    %r8,%rdx
  40166b:	e8 80 f6 ff ff       	callq  400cf0 <sscanf@plt>
  401670:	83 f8 04             	cmp    $0x4,%eax
  401673:	74 1b                	je     401690 <_Z1ev.part.0+0x50>
  401675:	bf 20 25 40 00       	mov    $0x402520,%edi
  40167a:	e8 a1 f5 ff ff       	callq  400c20 <puts@plt>
  40167f:	bf 48 25 40 00       	mov    $0x402548,%edi
  401684:	e8 97 f5 ff ff       	callq  400c20 <puts@plt>
  401689:	c9                   	leaveq 
  40168a:	c3                   	retq   
  40168b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401690:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
  401697:	be 18 26 40 00       	mov    $0x402618,%esi
  40169c:	e8 df f6 ff ff       	callq  400d80 <strcmp@plt>
  4016a1:	85 c0                	test   %eax,%eax
  4016a3:	75 d0                	jne    401675 <_Z1ev.part.0+0x35>
  4016a5:	bf c0 24 40 00       	mov    $0x4024c0,%edi
  4016aa:	e8 71 f5 ff ff       	callq  400c20 <puts@plt>
  4016af:	bf e8 24 40 00       	mov    $0x4024e8,%edi
  4016b4:	e8 67 f5 ff ff       	callq  400c20 <puts@plt>
  4016b9:	e8 d2 fe ff ff       	callq  401590 <_Z12secret_phasev>
  4016be:	eb b5                	jmp    401675 <_Z1ev.part.0+0x35>

00000000004016c0 <_Z1ev>:
  4016c0:	83 3d 39 20 20 00 06 	cmpl   $0x6,0x202039(%rip)        # 603700 <ndefused>
  4016c7:	55                   	push   %rbp
  4016c8:	48 89 e5             	mov    %rsp,%rbp
  4016cb:	74 03                	je     4016d0 <_Z1ev+0x10>
  4016cd:	5d                   	pop    %rbp
  4016ce:	c3                   	retq   
  4016cf:	90                   	nop
  4016d0:	5d                   	pop    %rbp
  4016d1:	e9 6a ff ff ff       	jmpq   401640 <_Z1ev.part.0>
  4016d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4016dd:	00 00 00 

00000000004016e0 <_ZL4skipv>:
  4016e0:	48 63 05 19 20 20 00 	movslq 0x202019(%rip),%rax        # 603700 <ndefused>
  4016e7:	55                   	push   %rbp
  4016e8:	48 89 e5             	mov    %rsp,%rbp
  4016eb:	41 54                	push   %r12
  4016ed:	53                   	push   %rbx
  4016ee:	83 f8 13             	cmp    $0x13,%eax
  4016f1:	77 55                	ja     401748 <_ZL4skipv+0x68>
  4016f3:	48 8d 3c 80          	lea    (%rax,%rax,4),%rdi
  4016f7:	48 8b 15 e2 1f 20 00 	mov    0x201fe2(%rip),%rdx        # 6036e0 <infile>
  4016fe:	be a0 00 00 00       	mov    $0xa0,%esi
  401703:	48 c1 e7 05          	shl    $0x5,%rdi
  401707:	48 81 c7 20 37 60 00 	add    $0x603720,%rdi
  40170e:	e8 9d f5 ff ff       	callq  400cb0 <fgets@plt>
  401713:	48 85 c0             	test   %rax,%rax
  401716:	49 89 c4             	mov    %rax,%r12
  401719:	74 25                	je     401740 <_ZL4skipv+0x60>
  40171b:	48 89 c3             	mov    %rax,%rbx
  40171e:	eb 0d                	jmp    40172d <_ZL4skipv+0x4d>
  401720:	48 83 c3 01          	add    $0x1,%rbx
  401724:	e8 87 f6 ff ff       	callq  400db0 <isspace@plt>
  401729:	85 c0                	test   %eax,%eax
  40172b:	74 13                	je     401740 <_ZL4skipv+0x60>
  40172d:	0f be 3b             	movsbl (%rbx),%edi
  401730:	40 84 ff             	test   %dil,%dil
  401733:	75 eb                	jne    401720 <_ZL4skipv+0x40>
  401735:	48 63 05 c4 1f 20 00 	movslq 0x201fc4(%rip),%rax        # 603700 <ndefused>
  40173c:	eb b5                	jmp    4016f3 <_ZL4skipv+0x13>
  40173e:	66 90                	xchg   %ax,%ax
  401740:	4c 89 e0             	mov    %r12,%rax
  401743:	5b                   	pop    %rbx
  401744:	41 5c                	pop    %r12
  401746:	5d                   	pop    %rbp
  401747:	c3                   	retq   
  401748:	b9 00 27 40 00       	mov    $0x402700,%ecx
  40174d:	ba bd 00 00 00       	mov    $0xbd,%edx
  401752:	be 24 26 40 00       	mov    $0x402624,%esi
  401757:	bf 90 25 40 00       	mov    $0x402590,%edi
  40175c:	e8 df f4 ff ff       	callq  400c40 <__assert_fail@plt>
  401761:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401766:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40176d:	00 00 00 

0000000000401770 <_Z13invalid_phasePc>:
  401770:	55                   	push   %rbp
  401771:	48 89 fe             	mov    %rdi,%rsi
  401774:	31 c0                	xor    %eax,%eax
  401776:	bf 2f 26 40 00       	mov    $0x40262f,%edi
  40177b:	48 89 e5             	mov    %rsp,%rbp
  40177e:	e8 5d f4 ff ff       	callq  400be0 <printf@plt>
  401783:	bf 08 00 00 00       	mov    $0x8,%edi
  401788:	e8 a3 f4 ff ff       	callq  400c30 <exit@plt>
  40178d:	0f 1f 00             	nopl   (%rax)

0000000000401790 <_Z15initialize_bombv>:
  401790:	55                   	push   %rbp
  401791:	be e0 15 40 00       	mov    $0x4015e0,%esi
  401796:	bf 02 00 00 00       	mov    $0x2,%edi
  40179b:	48 89 e5             	mov    %rsp,%rbp
  40179e:	48 81 ec 00 20 00 00 	sub    $0x2000,%rsp
  4017a5:	e8 86 f5 ff ff       	callq  400d30 <signal@plt>
  4017aa:	48 8b 3d 1f 1f 20 00 	mov    0x201f1f(%rip),%rdi        # 6036d0 <stdout@@GLIBC_2.2.5>
  4017b1:	31 f6                	xor    %esi,%esi
  4017b3:	b9 00 20 00 00       	mov    $0x2000,%ecx
  4017b8:	ba 02 00 00 00       	mov    $0x2,%edx
  4017bd:	e8 8e f4 ff ff       	callq  400c50 <setvbuf@plt>
  4017c2:	48 8b 3d ff 1e 20 00 	mov    0x201eff(%rip),%rdi        # 6036c8 <stderr@@GLIBC_2.2.5>
  4017c9:	31 f6                	xor    %esi,%esi
  4017cb:	b9 00 20 00 00       	mov    $0x2000,%ecx
  4017d0:	ba 02 00 00 00       	mov    $0x2,%edx
  4017d5:	e8 76 f4 ff ff       	callq  400c50 <setvbuf@plt>
  4017da:	48 8d bd 00 e0 ff ff 	lea    -0x2000(%rbp),%rdi
  4017e1:	e8 ba 08 00 00       	callq  4020a0 <_Z11init_driverPc>
  4017e6:	85 c0                	test   %eax,%eax
  4017e8:	78 0c                	js     4017f6 <_Z15initialize_bombv+0x66>
  4017ea:	bf c0 16 40 00       	mov    $0x4016c0,%edi
  4017ef:	e8 1c 0b 00 00       	callq  402310 <atexit>
  4017f4:	c9                   	leaveq 
  4017f5:	c3                   	retq   
  4017f6:	48 8d b5 00 e0 ff ff 	lea    -0x2000(%rbp),%rsi
  4017fd:	bf 40 26 40 00       	mov    $0x402640,%edi
  401802:	31 c0                	xor    %eax,%eax
  401804:	e8 d7 f3 ff ff       	callq  400be0 <printf@plt>
  401809:	bf 08 00 00 00       	mov    $0x8,%edi
  40180e:	e8 1d f4 ff ff       	callq  400c30 <exit@plt>
  401813:	0f 1f 00             	nopl   (%rax)
  401816:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40181d:	00 00 00 

0000000000401820 <_Z21initialize_bomb_solvev>:
  401820:	55                   	push   %rbp
  401821:	48 89 e5             	mov    %rsp,%rbp
  401824:	5d                   	pop    %rbp
  401825:	c3                   	retq   
  401826:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40182d:	00 00 00 

0000000000401830 <_Z10blank_linePc>:
  401830:	55                   	push   %rbp
  401831:	48 89 e5             	mov    %rsp,%rbp
  401834:	53                   	push   %rbx
  401835:	48 89 fb             	mov    %rdi,%rbx
  401838:	48 83 ec 08          	sub    $0x8,%rsp
  40183c:	eb 0f                	jmp    40184d <_Z10blank_linePc+0x1d>
  40183e:	66 90                	xchg   %ax,%ax
  401840:	48 83 c3 01          	add    $0x1,%rbx
  401844:	e8 67 f5 ff ff       	callq  400db0 <isspace@plt>
  401849:	85 c0                	test   %eax,%eax
  40184b:	74 0d                	je     40185a <_Z10blank_linePc+0x2a>
  40184d:	0f be 3b             	movsbl (%rbx),%edi
  401850:	40 84 ff             	test   %dil,%dil
  401853:	75 eb                	jne    401840 <_Z10blank_linePc+0x10>
  401855:	b8 01 00 00 00       	mov    $0x1,%eax
  40185a:	48 83 c4 08          	add    $0x8,%rsp
  40185e:	5b                   	pop    %rbx
  40185f:	5d                   	pop    %rbp
  401860:	c3                   	retq   
  401861:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401866:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40186d:	00 00 00 

0000000000401870 <_Z8send_msgi>:
  401870:	55                   	push   %rbp
  401871:	48 89 e5             	mov    %rsp,%rbp
  401874:	53                   	push   %rbx
  401875:	89 fb                	mov    %edi,%ebx
  401877:	bf c0 43 60 00       	mov    $0x6043c0,%edi
  40187c:	48 81 ec 08 40 00 00 	sub    $0x4008,%rsp
  401883:	e8 38 f4 ff ff       	callq  400cc0 <strlen@plt>
  401888:	48 83 c0 64          	add    $0x64,%rax
  40188c:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  401892:	77 7f                	ja     401913 <_Z8send_msgi+0xa3>
  401894:	85 db                	test   %ebx,%ebx
  401896:	b8 62 26 40 00       	mov    $0x402662,%eax
  40189b:	b9 5a 26 40 00       	mov    $0x40265a,%ecx
  4018a0:	48 0f 44 c8          	cmove  %rax,%rcx
  4018a4:	8b 05 56 1e 20 00    	mov    0x201e56(%rip),%eax        # 603700 <ndefused>
  4018aa:	8b 15 f4 1d 20 00    	mov    0x201df4(%rip),%edx        # 6036a4 <bomb_id>
  4018b0:	48 8d bd f0 bf ff ff 	lea    -0x4010(%rbp),%rdi
  4018b7:	41 b9 c0 43 60 00    	mov    $0x6043c0,%r9d
  4018bd:	be 6b 26 40 00       	mov    $0x40266b,%esi
  4018c2:	44 8d 40 01          	lea    0x1(%rax),%r8d
  4018c6:	31 c0                	xor    %eax,%eax
  4018c8:	e8 13 f4 ff ff       	callq  400ce0 <sprintf@plt>
  4018cd:	4c 8d 85 f0 df ff ff 	lea    -0x2010(%rbp),%r8
  4018d4:	48 8d 95 f0 bf ff ff 	lea    -0x4010(%rbp),%rdx
  4018db:	31 c9                	xor    %ecx,%ecx
  4018dd:	be 80 36 60 00       	mov    $0x603680,%esi
  4018e2:	bf 98 36 60 00       	mov    $0x603698,%edi
  4018e7:	e8 e4 08 00 00       	callq  4021d0 <_Z11driver_postPcS_S_iS_>
  4018ec:	85 c0                	test   %eax,%eax
  4018ee:	78 10                	js     401900 <_Z8send_msgi+0x90>
  4018f0:	48 81 c4 08 40 00 00 	add    $0x4008,%rsp
  4018f7:	5b                   	pop    %rbx
  4018f8:	5d                   	pop    %rbp
  4018f9:	c3                   	retq   
  4018fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  401900:	48 8d bd f0 df ff ff 	lea    -0x2010(%rbp),%rdi
  401907:	e8 14 f3 ff ff       	callq  400c20 <puts@plt>
  40190c:	31 ff                	xor    %edi,%edi
  40190e:	e8 7d f3 ff ff       	callq  400c90 <_exit@plt>
  401913:	bf b0 25 40 00       	mov    $0x4025b0,%edi
  401918:	e8 03 f3 ff ff       	callq  400c20 <puts@plt>
  40191d:	bf 08 00 00 00       	mov    $0x8,%edi
  401922:	e8 69 f3 ff ff       	callq  400c90 <_exit@plt>
  401927:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40192e:	00 00 

0000000000401930 <_Z12explode_bombv>:
  401930:	55                   	push   %rbp
  401931:	bf 77 26 40 00       	mov    $0x402677,%edi
  401936:	48 89 e5             	mov    %rsp,%rbp
  401939:	e8 e2 f2 ff ff       	callq  400c20 <puts@plt>
  40193e:	bf 80 26 40 00       	mov    $0x402680,%edi
  401943:	e8 d8 f2 ff ff       	callq  400c20 <puts@plt>
  401948:	31 ff                	xor    %edi,%edi
  40194a:	e8 21 ff ff ff       	callq  401870 <_Z8send_msgi>
  40194f:	bf d8 25 40 00       	mov    $0x4025d8,%edi
  401954:	e8 c7 f2 ff ff       	callq  400c20 <puts@plt>
  401959:	bf 08 00 00 00       	mov    $0x8,%edi
  40195e:	e8 2d f3 ff ff       	callq  400c90 <_exit@plt>
  401963:	0f 1f 00             	nopl   (%rax)
  401966:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40196d:	00 00 00 

0000000000401970 <_Z16read_six_numbersPKcPi>:
  401970:	55                   	push   %rbp
  401971:	48 8d 46 14          	lea    0x14(%rsi),%rax
  401975:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  401979:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
  40197d:	4c 8d 46 08          	lea    0x8(%rsi),%r8
  401981:	48 89 f2             	mov    %rsi,%rdx
  401984:	48 89 e5             	mov    %rsp,%rbp
  401987:	50                   	push   %rax
  401988:	48 8d 46 10          	lea    0x10(%rsi),%rax
  40198c:	be 97 26 40 00       	mov    $0x402697,%esi
  401991:	50                   	push   %rax
  401992:	31 c0                	xor    %eax,%eax
  401994:	e8 57 f3 ff ff       	callq  400cf0 <sscanf@plt>
  401999:	83 f8 05             	cmp    $0x5,%eax
  40199c:	5a                   	pop    %rdx
  40199d:	59                   	pop    %rcx
  40199e:	7e 02                	jle    4019a2 <_Z16read_six_numbersPKcPi+0x32>
  4019a0:	c9                   	leaveq 
  4019a1:	c3                   	retq   
  4019a2:	e8 89 ff ff ff       	callq  401930 <_Z12explode_bombv>
  4019a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4019ae:	00 00 

00000000004019b0 <_Z9read_linev>:
  4019b0:	55                   	push   %rbp
  4019b1:	48 89 e5             	mov    %rsp,%rbp
  4019b4:	53                   	push   %rbx
  4019b5:	48 83 ec 08          	sub    $0x8,%rsp
  4019b9:	e8 22 fd ff ff       	callq  4016e0 <_ZL4skipv>
  4019be:	48 85 c0             	test   %rax,%rax
  4019c1:	74 5d                	je     401a20 <_Z9read_linev+0x70>
  4019c3:	48 63 05 36 1d 20 00 	movslq 0x201d36(%rip),%rax        # 603700 <ndefused>
  4019ca:	48 8d 1c 80          	lea    (%rax,%rax,4),%rbx
  4019ce:	48 c1 e3 05          	shl    $0x5,%rbx
  4019d2:	48 81 c3 20 37 60 00 	add    $0x603720,%rbx
  4019d9:	48 89 df             	mov    %rbx,%rdi
  4019dc:	e8 df f2 ff ff       	callq  400cc0 <strlen@plt>
  4019e1:	3d 9e 00 00 00       	cmp    $0x9e,%eax
  4019e6:	0f 8f 8c 00 00 00    	jg     401a78 <_Z9read_linev+0xc8>
  4019ec:	83 e8 01             	sub    $0x1,%eax
  4019ef:	48 89 de             	mov    %rbx,%rsi
  4019f2:	bf c0 43 60 00       	mov    $0x6043c0,%edi
  4019f7:	48 98                	cltq   
  4019f9:	c6 04 03 00          	movb   $0x0,(%rbx,%rax,1)
  4019fd:	e8 8e f3 ff ff       	callq  400d90 <strcpy@plt>
  401a02:	48 63 05 f7 1c 20 00 	movslq 0x201cf7(%rip),%rax        # 603700 <ndefused>
  401a09:	48 83 c4 08          	add    $0x8,%rsp
  401a0d:	5b                   	pop    %rbx
  401a0e:	5d                   	pop    %rbp
  401a0f:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  401a13:	48 c1 e0 05          	shl    $0x5,%rax
  401a17:	48 05 20 37 60 00    	add    $0x603720,%rax
  401a1d:	c3                   	retq   
  401a1e:	66 90                	xchg   %ax,%ax
  401a20:	48 8b 05 99 1c 20 00 	mov    0x201c99(%rip),%rax        # 6036c0 <stdin@@GLIBC_2.2.5>
  401a27:	48 39 05 b2 1c 20 00 	cmp    %rax,0x201cb2(%rip)        # 6036e0 <infile>
  401a2e:	74 7b                	je     401aab <_Z9read_linev+0xfb>
  401a30:	bf c7 26 40 00       	mov    $0x4026c7,%edi
  401a35:	e8 16 f3 ff ff       	callq  400d50 <getenv@plt>
  401a3a:	48 85 c0             	test   %rax,%rax
  401a3d:	74 11                	je     401a50 <_Z9read_linev+0xa0>
  401a3f:	31 ff                	xor    %edi,%edi
  401a41:	e8 4a f2 ff ff       	callq  400c90 <_exit@plt>
  401a46:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  401a4d:	00 00 00 
  401a50:	48 8b 05 69 1c 20 00 	mov    0x201c69(%rip),%rax        # 6036c0 <stdin@@GLIBC_2.2.5>
  401a57:	48 89 05 82 1c 20 00 	mov    %rax,0x201c82(%rip)        # 6036e0 <infile>
  401a5e:	e8 7d fc ff ff       	callq  4016e0 <_ZL4skipv>
  401a63:	48 85 c0             	test   %rax,%rax
  401a66:	0f 85 57 ff ff ff    	jne    4019c3 <_Z9read_linev+0x13>
  401a6c:	bf a9 26 40 00       	mov    $0x4026a9,%edi
  401a71:	e8 aa f1 ff ff       	callq  400c20 <puts@plt>
  401a76:	eb c7                	jmp    401a3f <_Z9read_linev+0x8f>
  401a78:	bf d2 26 40 00       	mov    $0x4026d2,%edi
  401a7d:	e8 9e f1 ff ff       	callq  400c20 <puts@plt>
  401a82:	8b 05 78 1c 20 00    	mov    0x201c78(%rip),%eax        # 603700 <ndefused>
  401a88:	be ed 26 40 00       	mov    $0x4026ed,%esi
  401a8d:	8d 78 01             	lea    0x1(%rax),%edi
  401a90:	48 63 ff             	movslq %edi,%rdi
  401a93:	48 69 ff a0 00 00 00 	imul   $0xa0,%rdi,%rdi
  401a9a:	48 81 c7 20 37 60 00 	add    $0x603720,%rdi
  401aa1:	e8 ea f2 ff ff       	callq  400d90 <strcpy@plt>
  401aa6:	e8 85 fe ff ff       	callq  401930 <_Z12explode_bombv>
  401aab:	bf a9 26 40 00       	mov    $0x4026a9,%edi
  401ab0:	e8 6b f1 ff ff       	callq  400c20 <puts@plt>
  401ab5:	bf 08 00 00 00       	mov    $0x8,%edi
  401aba:	e8 d1 f1 ff ff       	callq  400c90 <_exit@plt>
  401abf:	90                   	nop

0000000000401ac0 <_Z13phase_defusedv>:
  401ac0:	55                   	push   %rbp
  401ac1:	bf 01 00 00 00       	mov    $0x1,%edi
  401ac6:	48 89 e5             	mov    %rsp,%rbp
  401ac9:	e8 a2 fd ff ff       	callq  401870 <_Z8send_msgi>
  401ace:	83 05 2b 1c 20 00 01 	addl   $0x1,0x201c2b(%rip)        # 603700 <ndefused>
  401ad5:	5d                   	pop    %rbp
  401ad6:	c3                   	retq   
  401ad7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  401ade:	00 00 

0000000000401ae0 <_Z15sigalrm_handleri>:
  401ae0:	55                   	push   %rbp
  401ae1:	48 8b 3d e0 1b 20 00 	mov    0x201be0(%rip),%rdi        # 6036c8 <stderr@@GLIBC_2.2.5>
  401ae8:	31 d2                	xor    %edx,%edx
  401aea:	be 10 27 40 00       	mov    $0x402710,%esi
  401aef:	31 c0                	xor    %eax,%eax
  401af1:	48 89 e5             	mov    %rsp,%rbp
  401af4:	e8 d7 f2 ff ff       	callq  400dd0 <fprintf@plt>
  401af9:	bf 01 00 00 00       	mov    $0x1,%edi
  401afe:	e8 8d f1 ff ff       	callq  400c90 <_exit@plt>
  401b03:	0f 1f 00             	nopl   (%rax)
  401b06:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  401b0d:	00 00 00 

0000000000401b10 <_ZL13rio_readlinebP5rio_tPvm.constprop.0>:
  401b10:	55                   	push   %rbp
  401b11:	48 89 e5             	mov    %rsp,%rbp
  401b14:	41 57                	push   %r15
  401b16:	41 56                	push   %r14
  401b18:	41 55                	push   %r13
  401b1a:	41 54                	push   %r12
  401b1c:	4c 8d 67 10          	lea    0x10(%rdi),%r12
  401b20:	53                   	push   %rbx
  401b21:	49 89 f6             	mov    %rsi,%r14
  401b24:	48 89 fb             	mov    %rdi,%rbx
  401b27:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  401b2d:	48 83 ec 08          	sub    $0x8,%rsp
  401b31:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401b38:	44 8b 7b 04          	mov    0x4(%rbx),%r15d
  401b3c:	45 85 ff             	test   %r15d,%r15d
  401b3f:	7f 24                	jg     401b65 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0x55>
  401b41:	8b 3b                	mov    (%rbx),%edi
  401b43:	ba 00 20 00 00       	mov    $0x2000,%edx
  401b48:	4c 89 e6             	mov    %r12,%rsi
  401b4b:	e8 10 f1 ff ff       	callq  400c60 <read@plt>
  401b50:	85 c0                	test   %eax,%eax
  401b52:	41 89 c7             	mov    %eax,%r15d
  401b55:	89 43 04             	mov    %eax,0x4(%rbx)
  401b58:	78 46                	js     401ba0 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0x90>
  401b5a:	74 64                	je     401bc0 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0xb0>
  401b5c:	45 85 ff             	test   %r15d,%r15d
  401b5f:	4c 89 63 08          	mov    %r12,0x8(%rbx)
  401b63:	7e dc                	jle    401b41 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0x31>
  401b65:	48 8b 43 08          	mov    0x8(%rbx),%rax
  401b69:	41 83 ef 01          	sub    $0x1,%r15d
  401b6d:	49 83 c6 01          	add    $0x1,%r14
  401b71:	0f b6 10             	movzbl (%rax),%edx
  401b74:	48 83 c0 01          	add    $0x1,%rax
  401b78:	44 89 7b 04          	mov    %r15d,0x4(%rbx)
  401b7c:	48 89 43 08          	mov    %rax,0x8(%rbx)
  401b80:	80 fa 0a             	cmp    $0xa,%dl
  401b83:	41 88 56 ff          	mov    %dl,-0x1(%r14)
  401b87:	74 3f                	je     401bc8 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0xb8>
  401b89:	49 83 c5 01          	add    $0x1,%r13
  401b8d:	49 81 fd 00 20 00 00 	cmp    $0x2000,%r13
  401b94:	75 a2                	jne    401b38 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0x28>
  401b96:	b8 00 20 00 00       	mov    $0x2000,%eax
  401b9b:	eb 2e                	jmp    401bcb <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0xbb>
  401b9d:	0f 1f 00             	nopl   (%rax)
  401ba0:	e8 cb f1 ff ff       	callq  400d70 <__errno_location@plt>
  401ba5:	83 38 04             	cmpl   $0x4,(%rax)
  401ba8:	74 92                	je     401b3c <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0x2c>
  401baa:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  401bb1:	48 83 c4 08          	add    $0x8,%rsp
  401bb5:	5b                   	pop    %rbx
  401bb6:	41 5c                	pop    %r12
  401bb8:	41 5d                	pop    %r13
  401bba:	41 5e                	pop    %r14
  401bbc:	41 5f                	pop    %r15
  401bbe:	5d                   	pop    %rbp
  401bbf:	c3                   	retq   
  401bc0:	31 c0                	xor    %eax,%eax
  401bc2:	49 83 fd 01          	cmp    $0x1,%r13
  401bc6:	74 e9                	je     401bb1 <_ZL13rio_readlinebP5rio_tPvm.constprop.0+0xa1>
  401bc8:	4c 89 e8             	mov    %r13,%rax
  401bcb:	41 c6 06 00          	movb   $0x0,(%r14)
  401bcf:	48 83 c4 08          	add    $0x8,%rsp
  401bd3:	5b                   	pop    %rbx
  401bd4:	41 5c                	pop    %r12
  401bd6:	41 5d                	pop    %r13
  401bd8:	41 5e                	pop    %r14
  401bda:	41 5f                	pop    %r15
  401bdc:	5d                   	pop    %rbp
  401bdd:	c3                   	retq   
  401bde:	66 90                	xchg   %ax,%ax

0000000000401be0 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc>:
  401be0:	55                   	push   %rbp
  401be1:	48 89 e5             	mov    %rsp,%rbp
  401be4:	41 57                	push   %r15
  401be6:	41 56                	push   %r14
  401be8:	41 55                	push   %r13
  401bea:	41 54                	push   %r12
  401bec:	49 89 ff             	mov    %rdi,%r15
  401bef:	53                   	push   %rbx
  401bf0:	41 89 f4             	mov    %esi,%r12d
  401bf3:	bf 02 00 00 00       	mov    $0x2,%edi
  401bf8:	be 01 00 00 00       	mov    $0x1,%esi
  401bfd:	4d 89 ce             	mov    %r9,%r14
  401c00:	48 81 ec 68 c0 00 00 	sub    $0xc068,%rsp
  401c07:	48 89 95 98 3f ff ff 	mov    %rdx,-0xc068(%rbp)
  401c0e:	31 d2                	xor    %edx,%edx
  401c10:	48 89 8d 90 3f ff ff 	mov    %rcx,-0xc070(%rbp)
  401c17:	4c 89 85 88 3f ff ff 	mov    %r8,-0xc078(%rbp)
  401c1e:	4c 8b 6d 10          	mov    0x10(%rbp),%r13
  401c22:	c7 85 ac 3f ff ff 00 	movl   $0x0,-0xc054(%rbp)
  401c29:	00 00 00 
  401c2c:	e8 0f f1 ff ff       	callq  400d40 <socket@plt>
  401c31:	85 c0                	test   %eax,%eax
  401c33:	0f 88 d8 03 00 00    	js     402011 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x431>
  401c39:	4c 89 ff             	mov    %r15,%rdi
  401c3c:	89 c3                	mov    %eax,%ebx
  401c3e:	e8 bd ef ff ff       	callq  400c00 <gethostbyname@plt>
  401c43:	48 85 c0             	test   %rax,%rax
  401c46:	0f 84 e7 03 00 00    	je     402033 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x453>
  401c4c:	66 0f ef c0          	pxor   %xmm0,%xmm0
  401c50:	48 63 50 14          	movslq 0x14(%rax),%rdx
  401c54:	48 8b 40 18          	mov    0x18(%rax),%rax
  401c58:	b9 02 00 00 00       	mov    $0x2,%ecx
  401c5d:	66 41 c1 cc 08       	ror    $0x8,%r12w
  401c62:	0f 29 85 b0 3f ff ff 	movaps %xmm0,-0xc050(%rbp)
  401c69:	66 89 8d b0 3f ff ff 	mov    %cx,-0xc050(%rbp)
  401c70:	48 8d 8d b0 3f ff ff 	lea    -0xc050(%rbp),%rcx
  401c77:	48 8b 38             	mov    (%rax),%rdi
  401c7a:	48 8d 71 04          	lea    0x4(%rcx),%rsi
  401c7e:	e8 4d f0 ff ff       	callq  400cd0 <bcopy@plt>
  401c83:	48 8d b5 b0 3f ff ff 	lea    -0xc050(%rbp),%rsi
  401c8a:	ba 10 00 00 00       	mov    $0x10,%edx
  401c8f:	89 df                	mov    %ebx,%edi
  401c91:	66 44 89 a5 b2 3f ff 	mov    %r12w,-0xc04e(%rbp)
  401c98:	ff 
  401c99:	e8 82 f0 ff ff       	callq  400d20 <connect@plt>
  401c9e:	85 c0                	test   %eax,%eax
  401ca0:	0f 88 97 03 00 00    	js     40203d <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x45d>
  401ca6:	4c 89 ef             	mov    %r13,%rdi
  401ca9:	e8 12 f0 ff ff       	callq  400cc0 <strlen@plt>
  401cae:	48 8b bd 98 3f ff ff 	mov    -0xc068(%rbp),%rdi
  401cb5:	49 89 c7             	mov    %rax,%r15
  401cb8:	e8 03 f0 ff ff       	callq  400cc0 <strlen@plt>
  401cbd:	48 8b bd 90 3f ff ff 	mov    -0xc070(%rbp),%rdi
  401cc4:	49 89 c4             	mov    %rax,%r12
  401cc7:	e8 f4 ef ff ff       	callq  400cc0 <strlen@plt>
  401ccc:	4c 89 f7             	mov    %r14,%rdi
  401ccf:	49 01 c4             	add    %rax,%r12
  401cd2:	e8 e9 ef ff ff       	callq  400cc0 <strlen@plt>
  401cd7:	4b 8d 14 7f          	lea    (%r15,%r15,2),%rdx
  401cdb:	49 8d 84 04 80 00 00 	lea    0x80(%r12,%rax,1),%rax
  401ce2:	00 
  401ce3:	48 01 d0             	add    %rdx,%rax
  401ce6:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  401cec:	0f 87 f0 02 00 00    	ja     401fe2 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x402>
  401cf2:	4c 8d 8d c0 3f ff ff 	lea    -0xc040(%rbp),%r9
  401cf9:	31 c0                	xor    %eax,%eax
  401cfb:	b9 00 04 00 00       	mov    $0x400,%ecx
  401d00:	4c 89 cf             	mov    %r9,%rdi
  401d03:	4c 89 8d 80 3f ff ff 	mov    %r9,-0xc080(%rbp)
  401d0a:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  401d0d:	4c 89 ef             	mov    %r13,%rdi
  401d10:	e8 ab ef ff ff       	callq  400cc0 <strlen@plt>
  401d15:	85 c0                	test   %eax,%eax
  401d17:	4c 8b 8d 80 3f ff ff 	mov    -0xc080(%rbp),%r9
  401d1e:	0f 84 c4 00 00 00    	je     401de8 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x208>
  401d24:	83 e8 01             	sub    $0x1,%eax
  401d27:	4d 89 cc             	mov    %r9,%r12
  401d2a:	49 bf d9 ff 00 00 00 	movabs $0x2000000000ffd9,%r15
  401d31:	00 20 00 
  401d34:	49 8d 4c 05 01       	lea    0x1(%r13,%rax,1),%rcx
  401d39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401d40:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  401d45:	8d 50 d6             	lea    -0x2a(%rax),%edx
  401d48:	80 fa 35             	cmp    $0x35,%dl
  401d4b:	0f 86 0f 02 00 00    	jbe    401f60 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x380>
  401d51:	89 c2                	mov    %eax,%edx
  401d53:	83 e2 df             	and    $0xffffffdf,%edx
  401d56:	83 ea 41             	sub    $0x41,%edx
  401d59:	80 fa 19             	cmp    $0x19,%dl
  401d5c:	0f 86 08 02 00 00    	jbe    401f6a <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x38a>
  401d62:	3c 20                	cmp    $0x20,%al
  401d64:	0f 84 66 02 00 00    	je     401fd0 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3f0>
  401d6a:	8d 50 e0             	lea    -0x20(%rax),%edx
  401d6d:	80 fa 5f             	cmp    $0x5f,%dl
  401d70:	76 08                	jbe    401d7a <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x19a>
  401d72:	3c 09                	cmp    $0x9,%al
  401d74:	0f 85 61 02 00 00    	jne    401fdb <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3fb>
  401d7a:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401d81:	0f b6 d0             	movzbl %al,%edx
  401d84:	be c0 29 40 00       	mov    $0x4029c0,%esi
  401d89:	31 c0                	xor    %eax,%eax
  401d8b:	48 89 8d 78 3f ff ff 	mov    %rcx,-0xc088(%rbp)
  401d92:	4c 89 8d 80 3f ff ff 	mov    %r9,-0xc080(%rbp)
  401d99:	e8 42 ef ff ff       	callq  400ce0 <sprintf@plt>
  401d9e:	0f b6 85 d0 bf ff ff 	movzbl -0x4030(%rbp),%eax
  401da5:	48 8b 8d 78 3f ff ff 	mov    -0xc088(%rbp),%rcx
  401dac:	49 83 c5 01          	add    $0x1,%r13
  401db0:	49 83 c4 03          	add    $0x3,%r12
  401db4:	4c 8b 8d 80 3f ff ff 	mov    -0xc080(%rbp),%r9
  401dbb:	41 88 44 24 fd       	mov    %al,-0x3(%r12)
  401dc0:	0f b6 85 d1 bf ff ff 	movzbl -0x402f(%rbp),%eax
  401dc7:	41 88 44 24 fe       	mov    %al,-0x2(%r12)
  401dcc:	0f b6 85 d2 bf ff ff 	movzbl -0x402e(%rbp),%eax
  401dd3:	41 88 44 24 ff       	mov    %al,-0x1(%r12)
  401dd8:	49 39 cd             	cmp    %rcx,%r13
  401ddb:	0f 85 5f ff ff ff    	jne    401d40 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x160>
  401de1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401de8:	48 83 ec 08          	sub    $0x8,%rsp
  401dec:	48 8b 95 98 3f ff ff 	mov    -0xc068(%rbp),%rdx
  401df3:	4c 8b 85 88 3f ff ff 	mov    -0xc078(%rbp),%r8
  401dfa:	48 8b 8d 90 3f ff ff 	mov    -0xc070(%rbp),%rcx
  401e01:	41 51                	push   %r9
  401e03:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401e0a:	4d 89 f1             	mov    %r14,%r9
  401e0d:	be 40 29 40 00       	mov    $0x402940,%esi
  401e12:	31 c0                	xor    %eax,%eax
  401e14:	e8 c7 ee ff ff       	callq  400ce0 <sprintf@plt>
  401e19:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401e20:	e8 9b ee ff ff       	callq  400cc0 <strlen@plt>
  401e25:	49 89 c6             	mov    %rax,%r14
  401e28:	4d 85 f6             	test   %r14,%r14
  401e2b:	58                   	pop    %rax
  401e2c:	5a                   	pop    %rdx
  401e2d:	74 38                	je     401e67 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x287>
  401e2f:	4c 8d ad d0 bf ff ff 	lea    -0x4030(%rbp),%r13
  401e36:	4d 89 f4             	mov    %r14,%r12
  401e39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401e40:	4c 89 e2             	mov    %r12,%rdx
  401e43:	4c 89 ee             	mov    %r13,%rsi
  401e46:	89 df                	mov    %ebx,%edi
  401e48:	e8 93 ef ff ff       	callq  400de0 <write@plt>
  401e4d:	48 85 c0             	test   %rax,%rax
  401e50:	0f 8e 32 01 00 00    	jle    401f88 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3a8>
  401e56:	49 01 c5             	add    %rax,%r13
  401e59:	49 29 c4             	sub    %rax,%r12
  401e5c:	75 e2                	jne    401e40 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x260>
  401e5e:	4d 85 f6             	test   %r14,%r14
  401e61:	0f 88 2f 01 00 00    	js     401f96 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3b6>
  401e67:	48 8d 85 c0 9f ff ff 	lea    -0x6040(%rbp),%rax
  401e6e:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401e75:	48 8d bd c0 9f ff ff 	lea    -0x6040(%rbp),%rdi
  401e7c:	89 9d c0 9f ff ff    	mov    %ebx,-0x6040(%rbp)
  401e82:	c7 85 c4 9f ff ff 00 	movl   $0x0,-0x603c(%rbp)
  401e89:	00 00 00 
  401e8c:	48 83 c0 10          	add    $0x10,%rax
  401e90:	48 89 85 c8 9f ff ff 	mov    %rax,-0x6038(%rbp)
  401e97:	e8 74 fc ff ff       	callq  401b10 <_ZL13rio_readlinebP5rio_tPvm.constprop.0>
  401e9c:	48 85 c0             	test   %rax,%rax
  401e9f:	0f 8e 84 01 00 00    	jle    402029 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x449>
  401ea5:	48 8d 95 c0 5f ff ff 	lea    -0xa040(%rbp),%rdx
  401eac:	4c 8d 85 c0 7f ff ff 	lea    -0x8040(%rbp),%r8
  401eb3:	48 8d 8d ac 3f ff ff 	lea    -0xc054(%rbp),%rcx
  401eba:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401ec1:	31 c0                	xor    %eax,%eax
  401ec3:	be c7 29 40 00       	mov    $0x4029c7,%esi
  401ec8:	e8 23 ee ff ff       	callq  400cf0 <sscanf@plt>
  401ecd:	8b 95 ac 3f ff ff    	mov    -0xc054(%rbp),%edx
  401ed3:	81 fa c8 00 00 00    	cmp    $0xc8,%edx
  401ed9:	74 13                	je     401eee <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x30e>
  401edb:	e9 09 01 00 00       	jmpq   401fe9 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x409>
  401ee0:	e8 2b fc ff ff       	callq  401b10 <_ZL13rio_readlinebP5rio_tPvm.constprop.0>
  401ee5:	48 85 c0             	test   %rax,%rax
  401ee8:	0f 8e b2 00 00 00    	jle    401fa0 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c0>
  401eee:	48 8d bd d0 bf ff ff 	lea    -0x4030(%rbp),%rdi
  401ef5:	be d8 29 40 00       	mov    $0x4029d8,%esi
  401efa:	e8 81 ee ff ff       	callq  400d80 <strcmp@plt>
  401eff:	85 c0                	test   %eax,%eax
  401f01:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401f08:	48 8d bd c0 9f ff ff 	lea    -0x6040(%rbp),%rdi
  401f0f:	75 cf                	jne    401ee0 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x300>
  401f11:	e8 fa fb ff ff       	callq  401b10 <_ZL13rio_readlinebP5rio_tPvm.constprop.0>
  401f16:	48 85 c0             	test   %rax,%rax
  401f19:	0f 8e 28 01 00 00    	jle    402047 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x467>
  401f1f:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401f23:	48 8d b5 d0 bf ff ff 	lea    -0x4030(%rbp),%rsi
  401f2a:	e8 61 ee ff ff       	callq  400d90 <strcpy@plt>
  401f2f:	89 df                	mov    %ebx,%edi
  401f31:	e8 ba ec ff ff       	callq  400bf0 <close@plt>
  401f36:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401f3a:	be db 29 40 00       	mov    $0x4029db,%esi
  401f3f:	e8 3c ee ff ff       	callq  400d80 <strcmp@plt>
  401f44:	85 c0                	test   %eax,%eax
  401f46:	0f 95 c0             	setne  %al
  401f49:	0f b6 c0             	movzbl %al,%eax
  401f4c:	f7 d8                	neg    %eax
  401f4e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  401f52:	5b                   	pop    %rbx
  401f53:	41 5c                	pop    %r12
  401f55:	41 5d                	pop    %r13
  401f57:	41 5e                	pop    %r14
  401f59:	41 5f                	pop    %r15
  401f5b:	5d                   	pop    %rbp
  401f5c:	c3                   	retq   
  401f5d:	0f 1f 00             	nopl   (%rax)
  401f60:	49 0f a3 d7          	bt     %rdx,%r15
  401f64:	0f 83 e7 fd ff ff    	jae    401d51 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x171>
  401f6a:	41 88 04 24          	mov    %al,(%r12)
  401f6e:	49 83 c4 01          	add    $0x1,%r12
  401f72:	49 83 c5 01          	add    $0x1,%r13
  401f76:	49 39 cd             	cmp    %rcx,%r13
  401f79:	0f 85 c1 fd ff ff    	jne    401d40 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x160>
  401f7f:	e9 64 fe ff ff       	jmpq   401de8 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x208>
  401f84:	0f 1f 40 00          	nopl   0x0(%rax)
  401f88:	e8 e3 ed ff ff       	callq  400d70 <__errno_location@plt>
  401f8d:	83 38 04             	cmpl   $0x4,(%rax)
  401f90:	0f 84 aa fe ff ff    	je     401e40 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x260>
  401f96:	be f0 27 40 00       	mov    $0x4027f0,%esi
  401f9b:	eb 08                	jmp    401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  401f9d:	0f 1f 00             	nopl   (%rax)
  401fa0:	be 88 28 40 00       	mov    $0x402888,%esi
  401fa5:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401fa9:	e8 e2 ed ff ff       	callq  400d90 <strcpy@plt>
  401fae:	89 df                	mov    %ebx,%edi
  401fb0:	e8 3b ec ff ff       	callq  400bf0 <close@plt>
  401fb5:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  401fb9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401fbe:	5b                   	pop    %rbx
  401fbf:	41 5c                	pop    %r12
  401fc1:	41 5d                	pop    %r13
  401fc3:	41 5e                	pop    %r14
  401fc5:	41 5f                	pop    %r15
  401fc7:	5d                   	pop    %rbp
  401fc8:	c3                   	retq   
  401fc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401fd0:	41 c6 04 24 2b       	movb   $0x2b,(%r12)
  401fd5:	49 83 c4 01          	add    $0x1,%r12
  401fd9:	eb 97                	jmp    401f72 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x392>
  401fdb:	be f8 28 40 00       	mov    $0x4028f8,%esi
  401fe0:	eb c3                	jmp    401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  401fe2:	be b8 27 40 00       	mov    $0x4027b8,%esi
  401fe7:	eb bc                	jmp    401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  401fe9:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  401fed:	48 8d 8d c0 7f ff ff 	lea    -0x8040(%rbp),%rcx
  401ff4:	be 58 28 40 00       	mov    $0x402858,%esi
  401ff9:	31 c0                	xor    %eax,%eax
  401ffb:	e8 e0 ec ff ff       	callq  400ce0 <sprintf@plt>
  402000:	89 df                	mov    %ebx,%edi
  402002:	e8 e9 eb ff ff       	callq  400bf0 <close@plt>
  402007:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40200c:	e9 3d ff ff ff       	jmpq   401f4e <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x36e>
  402011:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  402015:	be 38 27 40 00       	mov    $0x402738,%esi
  40201a:	e8 71 ed ff ff       	callq  400d90 <strcpy@plt>
  40201f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402024:	e9 25 ff ff ff       	jmpq   401f4e <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x36e>
  402029:	be 20 28 40 00       	mov    $0x402820,%esi
  40202e:	e9 72 ff ff ff       	jmpq   401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  402033:	be 60 27 40 00       	mov    $0x402760,%esi
  402038:	e9 68 ff ff ff       	jmpq   401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  40203d:	be 90 27 40 00       	mov    $0x402790,%esi
  402042:	e9 5e ff ff ff       	jmpq   401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  402047:	be c0 28 40 00       	mov    $0x4028c0,%esi
  40204c:	e9 54 ff ff ff       	jmpq   401fa5 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc+0x3c5>
  402051:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  402056:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40205d:	00 00 00 

0000000000402060 <_Z12init_timeouti>:
  402060:	85 ff                	test   %edi,%edi
  402062:	74 34                	je     402098 <_Z12init_timeouti+0x38>
  402064:	55                   	push   %rbp
  402065:	be e0 1a 40 00       	mov    $0x401ae0,%esi
  40206a:	48 89 e5             	mov    %rsp,%rbp
  40206d:	53                   	push   %rbx
  40206e:	89 fb                	mov    %edi,%ebx
  402070:	bf 0e 00 00 00       	mov    $0xe,%edi
  402075:	48 83 ec 08          	sub    $0x8,%rsp
  402079:	e8 b2 ec ff ff       	callq  400d30 <signal@plt>
  40207e:	85 db                	test   %ebx,%ebx
  402080:	bf 00 00 00 00       	mov    $0x0,%edi
  402085:	0f 49 fb             	cmovns %ebx,%edi
  402088:	48 83 c4 08          	add    $0x8,%rsp
  40208c:	5b                   	pop    %rbx
  40208d:	5d                   	pop    %rbp
  40208e:	e9 cd ec ff ff       	jmpq   400d60 <alarm@plt>
  402093:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  402098:	f3 c3                	repz retq 
  40209a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000004020a0 <_Z11init_driverPc>:
  4020a0:	55                   	push   %rbp
  4020a1:	be 01 00 00 00       	mov    $0x1,%esi
  4020a6:	48 89 e5             	mov    %rsp,%rbp
  4020a9:	41 54                	push   %r12
  4020ab:	53                   	push   %rbx
  4020ac:	49 89 fc             	mov    %rdi,%r12
  4020af:	bf 0d 00 00 00       	mov    $0xd,%edi
  4020b4:	48 83 ec 10          	sub    $0x10,%rsp
  4020b8:	e8 73 ec ff ff       	callq  400d30 <signal@plt>
  4020bd:	be 01 00 00 00       	mov    $0x1,%esi
  4020c2:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4020c7:	e8 64 ec ff ff       	callq  400d30 <signal@plt>
  4020cc:	be 01 00 00 00       	mov    $0x1,%esi
  4020d1:	bf 1d 00 00 00       	mov    $0x1d,%edi
  4020d6:	e8 55 ec ff ff       	callq  400d30 <signal@plt>
  4020db:	31 d2                	xor    %edx,%edx
  4020dd:	be 01 00 00 00       	mov    $0x1,%esi
  4020e2:	bf 02 00 00 00       	mov    $0x2,%edi
  4020e7:	e8 54 ec ff ff       	callq  400d40 <socket@plt>
  4020ec:	85 c0                	test   %eax,%eax
  4020ee:	0f 88 7c 00 00 00    	js     402170 <_Z11init_driverPc+0xd0>
  4020f4:	bf de 29 40 00       	mov    $0x4029de,%edi
  4020f9:	89 c3                	mov    %eax,%ebx
  4020fb:	e8 00 eb ff ff       	callq  400c00 <gethostbyname@plt>
  402100:	48 85 c0             	test   %rax,%rax
  402103:	0f 84 a1 00 00 00    	je     4021aa <_Z11init_driverPc+0x10a>
  402109:	66 0f ef c0          	pxor   %xmm0,%xmm0
  40210d:	ba 02 00 00 00       	mov    $0x2,%edx
  402112:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
  402116:	48 8d 71 04          	lea    0x4(%rcx),%rsi
  40211a:	0f 29 45 e0          	movaps %xmm0,-0x20(%rbp)
  40211e:	66 89 55 e0          	mov    %dx,-0x20(%rbp)
  402122:	48 63 50 14          	movslq 0x14(%rax),%rdx
  402126:	48 8b 40 18          	mov    0x18(%rax),%rax
  40212a:	48 8b 38             	mov    (%rax),%rdi
  40212d:	e8 9e eb ff ff       	callq  400cd0 <bcopy@plt>
  402132:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
  402136:	b9 3b 6e 00 00       	mov    $0x6e3b,%ecx
  40213b:	ba 10 00 00 00       	mov    $0x10,%edx
  402140:	89 df                	mov    %ebx,%edi
  402142:	66 89 4d e2          	mov    %cx,-0x1e(%rbp)
  402146:	e8 d5 eb ff ff       	callq  400d20 <connect@plt>
  40214b:	85 c0                	test   %eax,%eax
  40214d:	78 39                	js     402188 <_Z11init_driverPc+0xe8>
  40214f:	89 df                	mov    %ebx,%edi
  402151:	e8 9a ea ff ff       	callq  400bf0 <close@plt>
  402156:	be db 29 40 00       	mov    $0x4029db,%esi
  40215b:	4c 89 e7             	mov    %r12,%rdi
  40215e:	e8 2d ec ff ff       	callq  400d90 <strcpy@plt>
  402163:	31 c0                	xor    %eax,%eax
  402165:	48 83 c4 10          	add    $0x10,%rsp
  402169:	5b                   	pop    %rbx
  40216a:	41 5c                	pop    %r12
  40216c:	5d                   	pop    %rbp
  40216d:	c3                   	retq   
  40216e:	66 90                	xchg   %ax,%ax
  402170:	be 38 27 40 00       	mov    $0x402738,%esi
  402175:	4c 89 e7             	mov    %r12,%rdi
  402178:	e8 13 ec ff ff       	callq  400d90 <strcpy@plt>
  40217d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  402182:	eb e1                	jmp    402165 <_Z11init_driverPc+0xc5>
  402184:	0f 1f 40 00          	nopl   0x0(%rax)
  402188:	ba de 29 40 00       	mov    $0x4029de,%edx
  40218d:	be 98 29 40 00       	mov    $0x402998,%esi
  402192:	4c 89 e7             	mov    %r12,%rdi
  402195:	31 c0                	xor    %eax,%eax
  402197:	e8 44 eb ff ff       	callq  400ce0 <sprintf@plt>
  40219c:	89 df                	mov    %ebx,%edi
  40219e:	e8 4d ea ff ff       	callq  400bf0 <close@plt>
  4021a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4021a8:	eb bb                	jmp    402165 <_Z11init_driverPc+0xc5>
  4021aa:	be 60 27 40 00       	mov    $0x402760,%esi
  4021af:	4c 89 e7             	mov    %r12,%rdi
  4021b2:	e8 d9 eb ff ff       	callq  400d90 <strcpy@plt>
  4021b7:	89 df                	mov    %ebx,%edi
  4021b9:	e8 32 ea ff ff       	callq  400bf0 <close@plt>
  4021be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4021c3:	eb a0                	jmp    402165 <_Z11init_driverPc+0xc5>
  4021c5:	90                   	nop
  4021c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4021cd:	00 00 00 

00000000004021d0 <_Z11driver_postPcS_S_iS_>:
  4021d0:	55                   	push   %rbp
  4021d1:	85 c9                	test   %ecx,%ecx
  4021d3:	48 89 e5             	mov    %rsp,%rbp
  4021d6:	41 56                	push   %r14
  4021d8:	41 55                	push   %r13
  4021da:	49 89 d5             	mov    %rdx,%r13
  4021dd:	41 54                	push   %r12
  4021df:	4d 89 c4             	mov    %r8,%r12
  4021e2:	53                   	push   %rbx
  4021e3:	75 3b                	jne    402220 <_Z11driver_postPcS_S_iS_+0x50>
  4021e5:	48 85 ff             	test   %rdi,%rdi
  4021e8:	48 89 fb             	mov    %rdi,%rbx
  4021eb:	74 11                	je     4021fe <_Z11driver_postPcS_S_iS_+0x2e>
  4021ed:	49 89 f6             	mov    %rsi,%r14
  4021f0:	be da 29 40 00       	mov    $0x4029da,%esi
  4021f5:	e8 86 eb ff ff       	callq  400d80 <strcmp@plt>
  4021fa:	85 c0                	test   %eax,%eax
  4021fc:	75 52                	jne    402250 <_Z11driver_postPcS_S_iS_+0x80>
  4021fe:	4c 89 e7             	mov    %r12,%rdi
  402201:	be db 29 40 00       	mov    $0x4029db,%esi
  402206:	e8 85 eb ff ff       	callq  400d90 <strcpy@plt>
  40220b:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  40220f:	31 c0                	xor    %eax,%eax
  402211:	5b                   	pop    %rbx
  402212:	41 5c                	pop    %r12
  402214:	41 5d                	pop    %r13
  402216:	41 5e                	pop    %r14
  402218:	5d                   	pop    %rbp
  402219:	c3                   	retq   
  40221a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  402220:	48 89 d6             	mov    %rdx,%rsi
  402223:	bf f4 29 40 00       	mov    $0x4029f4,%edi
  402228:	31 c0                	xor    %eax,%eax
  40222a:	e8 b1 e9 ff ff       	callq  400be0 <printf@plt>
  40222f:	4c 89 e7             	mov    %r12,%rdi
  402232:	be db 29 40 00       	mov    $0x4029db,%esi
  402237:	e8 54 eb ff ff       	callq  400d90 <strcpy@plt>
  40223c:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  402240:	31 c0                	xor    %eax,%eax
  402242:	5b                   	pop    %rbx
  402243:	41 5c                	pop    %r12
  402245:	41 5d                	pop    %r13
  402247:	41 5e                	pop    %r14
  402249:	5d                   	pop    %rbp
  40224a:	c3                   	retq   
  40224b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  402250:	41 54                	push   %r12
  402252:	41 55                	push   %r13
  402254:	48 89 d9             	mov    %rbx,%rcx
  402257:	4d 89 f0             	mov    %r14,%r8
  40225a:	ba 15 2a 40 00       	mov    $0x402a15,%edx
  40225f:	41 b9 0b 2a 40 00    	mov    $0x402a0b,%r9d
  402265:	be 6e 3b 00 00       	mov    $0x3b6e,%esi
  40226a:	bf de 29 40 00       	mov    $0x4029de,%edi
  40226f:	e8 6c f9 ff ff       	callq  401be0 <_Z7submitrPKciS0_S0_S0_S0_S0_Pc>
  402274:	5a                   	pop    %rdx
  402275:	59                   	pop    %rcx
  402276:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
  40227a:	5b                   	pop    %rbx
  40227b:	41 5c                	pop    %r12
  40227d:	41 5d                	pop    %r13
  40227f:	41 5e                	pop    %r14
  402281:	5d                   	pop    %rbp
  402282:	c3                   	retq   
  402283:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40228a:	00 00 00 
  40228d:	0f 1f 00             	nopl   (%rax)

0000000000402290 <__libc_csu_init>:
  402290:	41 57                	push   %r15
  402292:	41 89 ff             	mov    %edi,%r15d
  402295:	41 56                	push   %r14
  402297:	49 89 f6             	mov    %rsi,%r14
  40229a:	41 55                	push   %r13
  40229c:	49 89 d5             	mov    %rdx,%r13
  40229f:	41 54                	push   %r12
  4022a1:	4c 8d 25 48 0e 20 00 	lea    0x200e48(%rip),%r12        # 6030f0 <__frame_dummy_init_array_entry>
  4022a8:	55                   	push   %rbp
  4022a9:	48 8d 2d 50 0e 20 00 	lea    0x200e50(%rip),%rbp        # 603100 <__do_global_dtors_aux_fini_array_entry>
  4022b0:	53                   	push   %rbx
  4022b1:	4c 29 e5             	sub    %r12,%rbp
  4022b4:	31 db                	xor    %ebx,%ebx
  4022b6:	48 c1 fd 03          	sar    $0x3,%rbp
  4022ba:	48 83 ec 08          	sub    $0x8,%rsp
  4022be:	e8 ed e8 ff ff       	callq  400bb0 <_init>
  4022c3:	48 85 ed             	test   %rbp,%rbp
  4022c6:	74 1e                	je     4022e6 <__libc_csu_init+0x56>
  4022c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4022cf:	00 
  4022d0:	4c 89 ea             	mov    %r13,%rdx
  4022d3:	4c 89 f6             	mov    %r14,%rsi
  4022d6:	44 89 ff             	mov    %r15d,%edi
  4022d9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  4022dd:	48 83 c3 01          	add    $0x1,%rbx
  4022e1:	48 39 eb             	cmp    %rbp,%rbx
  4022e4:	75 ea                	jne    4022d0 <__libc_csu_init+0x40>
  4022e6:	48 83 c4 08          	add    $0x8,%rsp
  4022ea:	5b                   	pop    %rbx
  4022eb:	5d                   	pop    %rbp
  4022ec:	41 5c                	pop    %r12
  4022ee:	41 5d                	pop    %r13
  4022f0:	41 5e                	pop    %r14
  4022f2:	41 5f                	pop    %r15
  4022f4:	c3                   	retq   
  4022f5:	90                   	nop
  4022f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4022fd:	00 00 00 

0000000000402300 <__libc_csu_fini>:
  402300:	f3 c3                	repz retq 
  402302:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  402309:	00 00 00 
  40230c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000402310 <atexit>:
  402310:	48 8d 05 21 11 20 00 	lea    0x201121(%rip),%rax        # 603438 <__dso_handle>
  402317:	48 85 c0             	test   %rax,%rax
  40231a:	74 0a                	je     402326 <atexit+0x16>
  40231c:	48 8b 10             	mov    (%rax),%rdx
  40231f:	31 f6                	xor    %esi,%esi
  402321:	e9 7a e9 ff ff       	jmpq   400ca0 <__cxa_atexit@plt>
  402326:	31 d2                	xor    %edx,%edx
  402328:	eb f5                	jmp    40231f <atexit+0xf>

Disassembly of section .fini:

000000000040232c <_fini>:
  40232c:	48 83 ec 08          	sub    $0x8,%rsp
  402330:	48 83 c4 08          	add    $0x8,%rsp
  402334:	c3                   	retq   
