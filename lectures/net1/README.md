CS61 2020: Networking 1
============================

Today’s meeting is about networking.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

- For the networking part of our lectures, you will need to update the docker files and rebuild the docker.

- A process creates a pipe by first creating both of its ends and then forking its child.
Think about are their other types of inter-process communications that pipe cannot support? 
For example, what if one process opens a channel before it knows who will it will talk with.
Are there any applications that would benefit from from this?

- We will play with a few networking tools.
Try running the following command in docker and please report what you see in class.
We will explain what they are in class.
ping google.com 
nslookup google.com
traceroute google.com
You can replace google.com with any hostname you know of.