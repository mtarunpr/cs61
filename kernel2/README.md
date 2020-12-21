CS61 2020: Kernel 2
===================

Today’s lecture will go more in depth into the teaching kernel in the
`kernel1` lecture directory. (There is no code in the `kernel2` directory.)

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

1\. We are using the DemoOS kernel from the Kernel 1 lecture for today’s work,
so perform the advance work for the Kernel 1 lecture if you haven’t already.

2\. The DemoOS kernel boots two processes, `p-alice.cc` and `p-eve.cc`. In the
handout, Alice and Eve alternate execution. But we imagine Eve goes rogue and
attacks the OS with the goal of preventing Alice from printing. Think like an
attacker and make a list of potential ways Eve could prevent Alice from
running.
