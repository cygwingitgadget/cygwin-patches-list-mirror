Return-Path: <cygwin-patches-return-3600-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31452 invoked by alias); 19 Feb 2003 21:06:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31442 invoked from network); 19 Feb 2003 21:06:39 -0000
Date: Wed, 19 Feb 2003 21:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030219210637.GB28790@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz> <20030219012118.GC5253@redhat.com> <3E53A525.9080405@hekimian.com> <20030219175738.GA3544@redhat.com> <20030219194135.GE29232@cygbert.vinschen.de> <20030219201925.GA28790@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219201925.GA28790@cygbert.vinschen.de>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00249.txt.bz2

On Wed, Feb 19, 2003 at 09:19:25PM +0100, Corinna Vinschen wrote:
> > I'm going to test that *shiver*.
> 
> Well... as a first result:  I tried to write two 4K blocks with a
> lseek(16K), creating a 24K file which should use only 8K on disk.
> 
> It didn't work.
> 
> Unfortunaltely, NTFS5 seem to support sparseness only if the files
> are big enough or if the sparse blocks are big enough.  The above
> test worked for me beginning with an lseek of 129K.

This isn't what MSDN says.  They have an example which shows a 32Megs
file, taking only 8K on disk.  Somehow they didn't implement it exactly
according to their advertisement texts. *shrug*

Ok, my test case:

==== SNIP ====
#include <stdio.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/mman.h>
#include <errno.h>
#include <unistd.h>
#include <windows.h>
#include <sys/cygwin.h>

int
main()
{
  off_t seek = 184;
  int buf[4096];
  char *map;
  DWORD len;

  int fd = open ("sparse.test", O_WRONLY | O_CREAT | O_TRUNC, 0644);
  if (fd < 0)
    {
      printf ("open failed: %d \"%s\"\n", errno, strerror(errno));
      return 1;
    }
  // Write first block
  memset (buf, 1, 4096);
  write (fd, buf, 4096);

  // Seek 184K
  lseek (fd, seek * 1024, SEEK_CUR);

  // Write second block
  memset (buf, 2, 4096);
  write (fd, buf, 4096);
  
  // Print size values
  len = GetFileSize ((HANDLE)get_osfhandle (fd), NULL);
  printf ("Size:         %7luK\n", len >> 10);
  len = GetCompressedFileSize ("sparse.test", NULL);
  printf ("Size on disk: %7luK\n", len >> 10);

  close (fd);

  // Reopen for mmap
  fd = open ("sparse.test", O_RDWR);
  if (fd < 0)
    {
      printf ("open 2 failed: %d \"%s\"\n", errno, strerror(errno));
      return 1;
    }

  map = mmap (NULL, (seek + 8) * 1024, PROT_READ | PROT_WRITE,
	      MAP_SHARED, fd, 0);
  if (!map)
    {
      printf ("mmap failed: %d \"%s\"\n", errno, strerror(errno));
      return 1;
    }
  else
    {
      unsigned long i;

      // Check contents
      for (i = 0; i < 4096; ++i)
        if (map[i] != 1)
	  printf ("first page doesn't contain 1 in byte %lu\n", i);
      for (i = 4096; i < (seek + 8) * 1024 - 4096; ++i)
        if (map[i] != 0)
	  printf ("sparse pages don't contain 0 in byte %lu\n", i);
      for (i = (seek + 8) * 1024 - 4096; i < (seek + 8) * 1024; ++i)
        if (map[i] != 2)
	  printf ("last page doesn't contain 3 in byte %lu\n", i);

      // Write a 3 in the middle
      map[((seek + 8) * 1024) / 2] = 3;

      munmap (map, (seek + 8) * 1024);

      // Print new size values
      len = GetFileSize ((HANDLE)get_osfhandle (fd), NULL);
      printf ("Size:         %7luK\n", len >> 10);
      len = GetCompressedFileSize ("sparse.test", NULL);
      printf ("Size on disk: %7luK\n", len >> 10);
    }
  close (fd);
  return 0;
}
==== SNAP ====

This testcase worked pretty well.  The output of the first size infos:

Size:             192K
Size on disk:      64K

Creating the mmap works fine, checking all blocks returned the expected
result (no messages) and writing the byte in the middle of the block
changed the file size info to

Size:             192K
Size on disk:     128K

which, btw., does *not* correspond to the `Size' and `Size on disk'
info in the Explorer file properties dialog.  It stated:

Size:             192K
Size on disk:     128K

before and

Size:             192K
Size on disk:     192K

after writing the byte in the middle.

However, this shows a flaw in stat():  st_blocks is just a computed
value which we get from the size of the file returned by Windows.

The actual value of bytes allocated on the FS is returned by the
GetCompressedFileSize() function, for all files, regardless of normal,
compressed or sparsed.

Since st_blocks contains the number of blocks allocated, according to
the Linux man page and SUSv3, shouldn't we change st_blocks to reflect
the value of GetCompressedFileSize() now?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
