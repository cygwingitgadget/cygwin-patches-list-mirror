From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re[2]: st_blocks incorrect for files larger than 2Gbytes
Date: Wed, 26 Jul 2000 07:57:00 -0000
Message-id: <14788.000726@logos-m.ru>
References: <200007261344.JAA17559@envy.delorie.com>
X-SW-Source: 2000-q3/msg00031.html

Hi!

Wednesday, 26 July, 2000 DJ Delorie dj@delorie.com wrote:

>>   buf->st_blocks = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
>>
>> which way is preferable?

DD>Casting  buf->st_size  to (unsigned long) before doing the math is.
DD>off_t is signed, but negative sizes are meaningless.

Wed Jul 26 14:32:38 2000  Egor Duda <deo@logos-m.ru>

        * syscalls.cc: Make stat return correct st_blocks for files
          with size bigger than 2Gb and less than 4Gb


Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /home/duda_admin/cvs-mirror/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.37
diff -c -1 -r1.37 syscalls.cc
*** winsup/cygwin/syscalls.cc   2000/07/22 16:43:54     1.37
--- winsup/cygwin/syscalls.cc   2000/07/26 13:57:09
***************
*** 1092,1094 ****
            buf->st_blksize = S_BLKSIZE;
!           buf->st_blocks  = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
            FindClose (handle);
--- 1092,1094 ----
            buf->st_blksize = S_BLKSIZE;
!           buf->st_blocks  = ((unsigned long)buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
            FindClose (handle);


DD> However, this topic belongs on the newlib list, not the cygwin list.

i  see.  making stat to support files bigger than 4 gigs (maximum file
size    in    win32  is 2^64) requires to make changes in newlib. i've
cc'ed  my previous message to newlib mailing list. but for now i think
it's ok to patch cygwin.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

