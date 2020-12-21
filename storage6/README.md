CS61 2020: Storage 6
====================

Today’s meeting is about reference strings and cache consistency.

Advance work
------------

*Advance work should be completed before lecture, especially by active
listeners. There is nothing to turn in.*

A **reference string** is a sequence of addresses (e.g., file offsets)
in access order. We can use reference strings to reason abstractly
about the behavior of different caching algorithms.

1\. Consider the following reference string: 1 2 4 2 4 4 5 1 2. Assume
that every cache slot can hold exactly one address’s worth of data. If
this reference string were processed (for reading) by a one-slot
cache, what address would the cache hold at the end of the string?

2\. If the reference string were processed (for reading) by a
*two*-slot cache, what addresses would the cache’s slots hold at the
end of the string?

3\. To answer question #2, you had to make a choice about which cache
slot to replace when the cache has no available slots. How would you
describe your choice?
