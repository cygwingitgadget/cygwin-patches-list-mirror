Return-Path: <cygwin-patches-return-7357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16606 invoked by alias); 12 May 2011 18:51:58 -0000
Received: (qmail 16506 invoked by uid 22791); 12 May 2011 18:51:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 18:51:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 60A8A2C0577; Thu, 12 May 2011 20:51:20 +0200 (CEST)
Date: Thu, 12 May 2011 18:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512185120.GG3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <4DCC1E7C.2060804@cs.utoronto.ca> <20110512184233.GE3020@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110512184233.GE3020@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00123.txt.bz2

On May 12 20:42, Corinna Vinschen wrote:
> I created a test application with several heaps [...]

Btw., here's my test app.  It's ugly but it's just for testing the
results anyway.


Corinna

#include <stdio.h>
#define _WIN32_WINNT 0x0601
#include <windows.h>
#include <ddk/ntddk.h>
#include <ddk/ntapi.h>

typedef struct _MODULES
{
  ULONG count;
  DEBUG_MODULE_INFORMATION dmi[1];
} MODULES, *PMODULES;

typedef struct _HEAPS
{
  ULONG count;
  DEBUG_HEAP_INFORMATION dhi[1];
} HEAPS, *PHEAPS;

typedef struct _HEAP_BLOCK
{
  ULONG size;
  ULONG flags;
  ULONG unknown;
  ULONG addr;
} HEAP_BLOCK, *PHEAP_BLOCK;

#define HEAP_CREATE_ENABLE_EXECUTE 0x40000
int
main ()
{
  PDEBUG_BUFFER buf;
  NTSTATUS status;
  int i;
  HMODULE modules[100];
  DWORD needed = sizeof modules;

  HANDLE h0 = HeapCreate (0, 0, 0);
  ULONG lowfrag = 2;
  if (!HeapSetInformation (h0, HeapCompatibilityInformation,
			   &lowfrag, sizeof lowfrag))
    fprintf (stderr, "HeapSet: %lu\n", GetLastError ());
  printf ("alloc h0: %p %p\n", h0, HeapAlloc (h0, 0, 32));
  HANDLE h1 = HeapCreate (0, 0, 0);
  printf ("alloc h1: %p %p\n", h1, HeapAlloc (h1, 0, 32));
  HANDLE h1b = HeapCreate (0, 0, 65536);
  printf ("alloc h1b: %p %p\n", h1b, HeapAlloc (h1b, 0, 32));
  HANDLE h2 = HeapCreate (HEAP_NO_SERIALIZE, 4096, 4 * 65536);
  printf ("alloc h2: %p %p\n", h2, HeapAlloc (h2, 0, 32));
  HANDLE h3 = HeapCreate (HEAP_GENERATE_EXCEPTIONS, 4096, 8 * 65536);
  printf ("alloc h3: %p %p\n", h3, HeapAlloc (h3, 0, 32));
  HANDLE h4 = HeapCreate (HEAP_CREATE_ENABLE_EXECUTE, 4096, 0);
  printf ("alloc h4: %p %p\n", h4, HeapAlloc (h4, 0, 200000));
  HANDLE h5 = HeapCreate (0, 4096, 0);
  printf ("alloc h5: %p %p\n", h5, HeapAlloc (h5, 0, 2000000));
  buf = RtlCreateQueryDebugBuffer (0, FALSE);
  if (!buf)
    {
      fprintf (stderr, "RtlCreateQueryDebugBuffer returned NULL\n");
      return 1;
    }
  status = RtlQueryProcessDebugInformation (GetCurrentProcessId (),
					    PDI_MODULES | PDI_HEAPS
					    | PDI_HEAP_BLOCKS, buf);
  if (!NT_SUCCESS (status))
    {
      fprintf (stderr, "RtlQueryProcessDebugInformation returned 0x%08lx\n", status);
      return 1;
    }
#if 0
  PMODULES mods = (PMODULES) buf->ModuleInformation;
  if (!mods)
    fprintf (stderr, "mods is NULL\n");
  else
    {
      for (i = 0; i < mods->count; ++i)
      	printf ("%40s Base 0x%08lx, Size %8lu U 0x%08lx\n",
		mods->dmi[i].ImageName,
		mods->dmi[i].Base,
		mods->dmi[i].Size,
		mods->dmi[i].Unknown);
    }
#endif
  PHEAPS heaps = (PHEAPS) buf->HeapInformation;
  if (!heaps)
    fprintf (stderr, "heaps is NULL\n");
  else
    {
      for (i = 0; i < heaps->count; ++i)
	{
	  int r;

#if 1
	  printf ("%3d: base 0x%08lx, flags 0x%08lx, granularity %5hu, unknown %5hu\n"
		  "     allocated %8lu, committed %8lu, block count %lu\n"
		  "     reserved",
		  i,
		  heaps->dhi[i].Base,
		  heaps->dhi[i].Flags,
		  heaps->dhi[i].Granularity,
		  heaps->dhi[i].Unknown,
		  heaps->dhi[i].Allocated,
		  heaps->dhi[i].Committed,
		  heaps->dhi[i].BlockCount);
	  for (r = 0; r < 7; ++r)
	    printf (" %lu",
		    heaps->dhi[i].Reserved[r],
		    heaps->dhi[i].Reserved[r]);
	  puts ("");
#else
	  printf ("%3d: base 0x%08lx, flags 0x%08lx\n",
		  i,
		  heaps->dhi[i].Base,
		  heaps->dhi[i].Flags);
#endif
	  PHEAP_BLOCK blocks = (PHEAP_BLOCK) heaps->dhi[i].Blocks;
	  if (!blocks)
	    fprintf (stderr, "blocks is NULL\n");
	  else
	    {
	      uintptr_t addr = 0;
	      char flags[32];
	      printf ("     Blocks:\n");
	      for (r = 0; r < heaps->dhi[i].BlockCount; ++r)
		{
		  flags[0] = '\0';
		  if (blocks[r].flags & 2)
		    {
		      addr = blocks[r].addr;
		      strcpy (flags, "start");
		    }
		  else if (blocks[r].flags & 0x2f1) 
		    strcpy (flags, "fixed");
		  else if (blocks[r].flags & 0x20)
		    strcpy (flags, "moveable");
		  else if (blocks[r].flags & 0x100)
		    strcpy (flags, "free");
		  if (blocks[r].flags & 2)
		    printf ("     %3d: addr 0x%08lx, size %8lu, flags 0x%08lx, "
			    "unknown 0x%08lx\n",
			    r,
			    addr,
			    blocks[r].size,
			    blocks[r].flags,
			    blocks[r].unknown);
#if 0
		  else
		    printf ("     %3d: addr 0x%08lx, size %8lu, "
			    "flags 0x%08x %8s\n",
			    r,
			    addr,
			    blocks[r].size,
			    blocks[r].flags,
			    flags);
#endif
		  if (blocks[r].flags & 2)
		    addr += heaps->dhi[i].Granularity;
		  else
		    addr += blocks[r].size;
		}
	    }
	}
    }
  RtlDestroyQueryDebugBuffer (buf);
  getchar ();
  return 0;
}

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
