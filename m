From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: st_blocks incorrect for files larger than 2Gbytes
Date: Thu, 27 Jul 2000 07:16:00 -0000
Message-id: <2760.000727@logos-m.ru>
References: <20000726135017.G7599@cygnus.com>
X-SW-Source: 2000-q3/msg00034.html

Hi!

>>Wed Jul 26 14:32:38 2000 Egor Duda <deo@logos-m.ru>
>>
>>        * syscalls.cc: Make stat return correct st_blocks for files
>>          with size bigger than 2Gb and less than 4Gb

oops.  i  should  grep carefully next time. seems that i've overlooked
st_blocks assignment in fhandler_disk_file::fstat()

Thu Jul 27 13:03:57 2000   Egor Duda <deo@logos-m.ru>

        *  fhandler.cc:  (fhandler_disk_file::fstat)  Make stat return
        correct st_blocks for files with size bigger than 2Gb and less
        than 4Gb


Index: winsup/cygwin/fhandler.cc
===================================================================
RCS file: /home/duda_admin/cvs-mirror/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.24
diff -c -2 -r1.24 fhandler.cc
*** winsup/cygwin/fhandler.cc   2000/07/17 19:18:21     1.24
--- winsup/cygwin/fhandler.cc   2000/07/27 13:03:57
***************
*** 947,951 ****
  
    buf->st_blksize = S_BLKSIZE;
!   buf->st_blocks  = (buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
  
    /* Using a side effect: get_file_attibutes checks for
--- 947,951 ----
  
    buf->st_blksize = S_BLKSIZE;
!   buf->st_blocks  = ((unsigned long) buf->st_size + S_BLKSIZE-1) / S_BLKSIZE;
  
    /* Using a side effect: get_file_attibutes checks for


Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

