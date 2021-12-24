Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id ECA643858D35
 for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2021 00:29:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org ECA643858D35
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id A0B6DCB50
 for <cygwin-patches@cygwin.com>; Thu, 23 Dec 2021 19:29:48 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 9EC96CB1B
 for <cygwin-patches@cygwin.com>; Thu, 23 Dec 2021 19:29:48 -0500 (EST)
Date: Thu, 23 Dec 2021 16:29:48 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
Message-ID: <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, SPF_HELO_PASS, SPF_PASS, TXREP,
 WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 24 Dec 2021 00:29:50 -0000

On Thu, 23 Dec 2021, Ken Brown wrote:

> > -      for (ULONG j = 0; j < phi->NumberOfHandles; j++)
> > +      for (ULONG j = 0; j < min(phi->NumberOfHandles, n_handle); j++)
>
> Reading the preceding code, I don't see how n_handle could be less than
> phi->NumberOfHandles.  Can you explain?
>

Not really.  I saw this stack trace:
...
#3  0x0000000180062f13 in exception::handle (e=0x14cc4f0, frame=<optimized out>, in=<optimized out>, dispatch=<optimized out>) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/exceptions.cc:835
#4  0x00007ff8abd320cf in ntdll!.chkstk () from /c/Windows/SYSTEM32/ntdll.dll
#5  0x00007ff8abce1454 in ntdll!RtlRaiseException () from /c/Windows/SYSTEM32/ntdll.dll
#6  0x00007ff8abd30bfe in ntdll!KiUserExceptionDispatcher () from /c/Windows/SYSTEM32/ntdll.dll
#7  0x0000000180092687 in fhandler_pipe::get_query_hdl_per_process (this=this@entry=0x1803700f8, name=name@entry=0x14cc820 L"\\Device\\NamedPipe\\dd50a72ab4668b33-10348-pipe-nt-0x6E6", ntfn=ntfn@entry=0x8000c2ce0) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/fhandler_pipe.cc:1281
#8  0x0000000180092bdb in fhandler_pipe::temporary_query_hdl (this=this@entry=0x1803700f8) at /c/S/msys2-runtime/src/msys2-runtime/winsup/cygwin/fhandler_pipe.cc:1190
...

Line 1281 of fhandler_pipe.cc was
	  if (phi->Handles[j].GrantedAccess != access)

The only way I could see that causing an exception was if it was reading
past the end of the allocated memory, if j was greater than (or equal to)
n_handle.  Unfortunately, I haven't been able to catch it in a debugger
again, so I can't confirm this.  I took a core with 'dumper' but gdb
doesn't want to load it (it says Core file format not supported, maybe
something with msys2's gdb?).

