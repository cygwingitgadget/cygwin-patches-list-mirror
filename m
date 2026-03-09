Return-Path: <SRS0=g9mI=BJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 9A3F54BA2E0B
	for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2026 07:06:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A3F54BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A3F54BA2E0B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773039981; cv=none;
	b=QsrmHtElWu48wkXkolPdTIgaaylo6/JnrKoHuDns4tCmvFVc//yVlkdwLR1RnhppMk1yjWdFocgAXYNA5E9U+rJR34iwWvHNfElR2NhYbSTuR0jG8/sw9NikEZn2GQw6WyEQOw/Zi2tTYm+YvOyTmqqBf0o9Bn8UMmpol9h4JFM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773039981; c=relaxed/simple;
	bh=7e1f8Vji9/s/qaxVsEDGvRNZnZWsHgvahl19pYNHss0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=nQFL98AOWVtGkyW5mJgQzLU5xuSAxULx7Lf+QBo2FUhz4wy5fdL55PXabKyy5Zp9U+QTTyk7AGyz500cLjimB92Q2FbZbxqojRSg9O0MBtZwxtpBB675DuhBsTKzHLS2+7dYY+Xk7BIri+6IE5REI4KRpxJlnN2oDa303Q9NzWw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A3F54BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=seipkF2E
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260309070618741.GCOS.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 9 Mar 2026 16:06:18 +0900
Date: Mon, 9 Mar 2026 16:06:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Restore nat handles in all PTY-slave
 instances in GDB
Message-Id: <20260309160616.958c7ac13de20b76b3ea1c58@nifty.ne.jp>
In-Reply-To: <20260308111932.1380-1-takashi.yano@nifty.ne.jp>
References: <20260308111932.1380-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773039978;
 bh=dnPXvgNcE93zP3LGJDXnA2CEC9IMYRXX1oQYiLWb2AI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=seipkF2EjSwcYZvICVeKSB2FO5Osn4VwEX8tt1yIt8TGlfwd/tDXS6xi6VxUWT16PPh5McjB
 woGnjFwkZAOsQVqMfhUf5LWCfqP38nPacaPflzwjPlRY6I+Jn5hvF/+DModobGpWOTS/gcb9rH
 nRpIPMUJ2Hhvsfru+kFovUJifJs91WMZuqbo6a9rwlRi43BQ3R5gLVQrjHrq5TPIAMpktlyLTd
 Avbaqxn3Nj6Tnl7HExF40YmHQaYQL20iNCmErPSP5MSuJKAyi6vsCVnpG6/evIE0ovVkmfBI7w
 rxclHGNTU1Pti9ThpdzFpRlxLvRv+2vq7kg5A/XKHhIVir1A==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Fixup handles in ctty as well if ctty is a PTY-slave

On Sun,  8 Mar 2026 20:19:21 +0900
Takashi Yano wrote:
> If non-cygwin app is started in GDB and terminating it normally,
> re-running the non-cygwin app might fail in setup_pseudoconsole().
> 
> The error is something like:
> 
> $ gdb ./winsleep
> GNU gdb (GDB) (Cygwin 15.2-1) 15.2
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-cygwin".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./winsleep...
> (gdb) run
> Starting program: /home/yano/winsleep
> [New Thread 49324.0x14178]
> [Thread 49324.0x14178 exited with code 0]
> [Inferior 1 (process 49324) exited normally]
> (gdb) run
> Starting program: /home/yano/winsleep
>       0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudoConsole() failed. 00000057 80070057
>                            [New Thread 86480.0xfd4]
> [Thread 86480.0xfd4 exited with code 0]
> [Inferior 1 (process 86480) exited normally]
> (gdb)
> 
> The essential problem is lack of restoring nat handles for *ALL* the
> PTY-slave instances after closing pseudo console in GDB.
> 
> Restoring handles from pseudo console handles to simple pipe handles
> is not necessary in normal non-cygwin apps because pseudo console is
> setup in the stub process for the non-cygwin app and the stub process
> exits after the app is terminated.
> 
> However, for GDB, pseudo console is setup in GDB process in hooked
> CreateProcess() because GDB does not use exec() to run an inferior
> (debuggee). Therefore, after the inferior exits, nat handle must be
> restored to simple pipe handles.
> 
> The current code restores only handles in the PTY-slave instance
> that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
> this instance is different from the instance that will setup pseudo
> console, the nat handles are not restored correctly, then call to
> CreatePseudoConsole() causes error.
> 
> To solves this issue, restore nat handles in all the PTY-slave
> instances to simple pipe handles when the inferior exits with this
> patch.
> 
> Fixes: 8aeb3f3e5037 ("Cygwin: pty: Make apps using console APIs be able to debug with gdb.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 2c2917525..781273688 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1277,6 +1277,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
>  	      else
>  		hand_over_only (get_ttyp ());
>  	      ReleaseMutex (pipe_sw_mutex);
> +
> +	      HANDLE input_handle_nat, output_handle_nat;
>  	      if (need_restore_handles)
>  		{
>  		  pinfo p (get_ttyp ()->master_pid);
> @@ -1284,16 +1286,15 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
>  		    OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
>  		  if (pty_owner)
>  		    {
> -		      CloseHandle (get_handle_nat ());
>  		      DuplicateHandle (pty_owner,
>  				       get_ttyp ()->from_master_nat (),
> -				       GetCurrentProcess (), &get_handle_nat (),
> +				       GetCurrentProcess (),
> +				       &input_handle_nat,
>  				       0, TRUE, DUPLICATE_SAME_ACCESS);
> -		      CloseHandle (get_output_handle_nat ());
>  		      DuplicateHandle (pty_owner,
>  				       get_ttyp ()->to_master_nat (),
>  				       GetCurrentProcess (),
> -				       &get_output_handle_nat (),
> +				       &output_handle_nat,
>  				       0, TRUE, DUPLICATE_SAME_ACCESS);
>  		      CloseHandle (pty_owner);
>  		    }
> @@ -1313,11 +1314,26 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
>  		      CloseHandle (repl.to_master); /* not used. */
>  		      CloseHandle (repl.to_slave_nat); /* not used. */
>  		      CloseHandle (repl.to_slave); /* not used. */
> -		      CloseHandle (get_handle_nat ());
> -		      set_handle_nat (repl.from_master_nat);
> -		      CloseHandle (get_output_handle_nat ());
> -		      set_output_handle_nat (repl.to_master_nat);
> +		      input_handle_nat = repl.from_master_nat;
> +		      output_handle_nat = repl.to_master_nat;
>  		    }
> +
> +		  /* Restore nat handles in all pty slave instances */
> +		  HANDLE orig_input_handle_nat = get_handle_nat();
> +		  HANDLE orig_output_handle_nat = get_output_handle_nat();
> +		  cygheap_fdenum cfd (false);
> +		  while (cfd.next () >= 0)
> +		    if (cfd->get_device () == get_device ())
> +		      {
> +			fhandler_base *fh = cfd;
> +			fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
> +			if (ptys->get_handle_nat () == orig_input_handle_nat)
> +			  ptys->set_handle_nat (input_handle_nat);
> +			if (ptys->get_output_handle_nat () == orig_output_handle_nat)
> +			  ptys->set_output_handle_nat (output_handle_nat);
> +		      }
> +		  CloseHandle (orig_input_handle_nat);
> +		  CloseHandle (orig_output_handle_nat);
>  		}
>  	      myself->exec_dwProcessId = 0;
>  	      isHybrid = false;
> -- 
> 2.51.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
