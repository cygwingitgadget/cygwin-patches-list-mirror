Return-Path: <SRS0=dvnW=CF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 26D674BA2E17
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 08:14:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 26D674BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 26D674BA2E17
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775463260; cv=none;
	b=AF/1/+oQgudn1yjRPA1tWWotDU31pIv9tK4BJ6vrNwTVu/k4QR443WD/Nd8zzrX+xGf/LDVt9JG/poLmeQMXhafiYAVI6eEHESWjKQNvDGVZywAnLJArDKamtvEo0DkWE75oNDpNhPFElMSDcy6sJLbDNgdRUcJLXEokWQx8aqk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775463260; c=relaxed/simple;
	bh=XgCBwOm/GJjkhl6mbpTpOyeLI9L6TP46UzSQtk60Zt0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=AQNkBxWREQRTJAdNNwsEqbxDLmcl26uaYXG2M2lRzI3JteX7A/XqTGXDL5Ul5ynmTna7PUgzfNOiAXpCibTZVKsCrOwUkj/BBKKFKPhvjA0a0UBkciEY2/RbQ5h9h7yBrPzTP17DkWVwK2oXLUnOj1z4gxnq3WmT6203eBD9tlw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 26D674BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=prhsAWjk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775463253; x=1776068053;
	i=johannes.schindelin@gmx.de;
	bh=NxKlQewSA6B210Qe5lo79Z5cKHaLdEDUJociFps5DN0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=prhsAWjk0BSgm9zA9Bge5Yy5QFaJUYLd4+7K7DDhk7ew4y9G8pqLpT/ohJkF5QyV
	 91vWgwyTWyWjY28h97Y7P2UMIlQoJrtiKZFIwbcawPASnqBJHeShtbtcVHD+Hqo5A
	 J35Jp207FCPMxCWBllXyKfIIdGv6hFhSxo/6ck4ag+mBgofECDCdX8XHalngUEMbp
	 kWWW40bDO3wMeEUk5U72/Ma0ganqTrgTeJrEoegHFRSw3n9x+eryOIdCGP6y5PniK
	 xCMUDmD+Z5vmDuxsuXBZGhSlO27Z6LNRfvKajsIcGbpzdmYPlh/E88b9JhsnX4Bmx
	 7RtEgKNzAmUzI0Xvmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1w8Ia93TW1-000WKh; Mon, 06
 Apr 2026 10:14:12 +0200
Date: Mon, 6 Apr 2026 10:14:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Restore nat handles in all PTY-slave
 instances in GDB
In-Reply-To: <20260309070645.5931-1-takashi.yano@nifty.ne.jp>
Message-ID: <c21ace27-1678-9399-6eae-c9cc01831d58@gmx.de>
References: <20260309070645.5931-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/rkWfCiUBW3meW5U/tjgz75cOkXfyikI7fHtucEQBMriknM8U8S
 7XIQKuFplc5RhWbv26EtuhZKlVEmM4pzSuwXCziPnVGetV5kaIRleNmdcbDpCDZL7FOUMvw
 W9KJZ3cZ+yVjLwKFXdpEBiUDe0OXejkKPcB7BreI+oujXIYr0g2+/eDBIkDXcDPciON2cpg
 0JD8axrCTC3O4NX/IDcaQ==
UI-OutboundReport: notjunk:1;M01:P0:I2OvB0Oy8jQ=;31EHEiEy11j5tzDpDzAYcf1VdkY
 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
 40
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_SHORT,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 6 Apr 2026, Takashi Yano wrote:

> If non-cygwin app is started in GDB and terminating it normally,
> re-running the non-cygwin app might fail in setup_pseudoconsole().
>=20
> The error is something like:
>=20
> $ gdb ./winsleep
> GNU gdb (GDB) (Cygwin 15.2-1) 15.2
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-cygwin".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
>=20
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
>       0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudo=
Console() failed. 00000057 80070057
>                            [New Thread 86480.0xfd4]
> [Thread 86480.0xfd4 exited with code 0]
> [Inferior 1 (process 86480) exited normally]
> (gdb)
>=20
> The essential problem is lack of restoring nat handles for *ALL* the
> PTY-slave instances after closing pseudo console in GDB.
>=20
> Restoring handles from pseudo console handles to simple pipe handles
> is not necessary in normal non-cygwin apps because pseudo console is
> setup in the stub process for the non-cygwin app and the stub process
> exits after the app is terminated.
>=20
> However, for GDB, pseudo console is setup in GDB process in hooked
> CreateProcess() because GDB does not use exec() to run an inferior
> (debuggee). Therefore, after the inferior exits, nat handle must be
> restored to simple pipe handles.
>=20
> The current code restores only handles in the PTY-slave instance
> that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
> this instance is different from the instance that will setup pseudo
> console, the nat handles are not restored correctly, then call to
> CreatePseudoConsole() causes error.

The fix is correct and the commit message is excellent: detailed repro,
clear root cause analysis, and a good explanation of why GDB is the
special case (it sets up the pseudo console in its own process rather
than in a stub that exits). Thank you!

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

One tiny typo in the commit message:

> To solves this issue, restore nat handles in all the PTY-slave
> instances to simple pipe handles when the inferior exits with this
> patch.

"To solves" should be "To solve". Since you apply your own patches, you
can fix that before pushing.

> In addition, if ctty is PTY-slave, fixup handles in it as well.

One optional suggestion for a possible follow-up: after this patch, the
handle-replacement pattern (iterate the fd table + ctty, compare old
handles, set new handles, close old handles) is now duplicated nearly
verbatim between `reset_switch_to_nat_pipe()` and `setup_pseudoconsole()`.
The only difference between the two blocks is the two new HANDLE values
passed in.

This would be a natural candidate for a small helper method, something
like this:

	void
	fhandler_pty_slave::replace_nat_handles (HANDLE new_input, HANDLE new_out=
put)
	{
	  HANDLE orig_input =3D get_handle_nat ();
	  HANDLE orig_output =3D get_output_handle_nat ();
	  cygheap_fdenum cfd (false);
	  while (cfd.next () >=3D 0)
	    if (cfd->get_device () =3D=3D get_device ())
	      {
		fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) (fhandler_base *) cf=
d;
		if (ptys->get_handle_nat () =3D=3D orig_input)
		  ptys->set_handle_nat (new_input);
		if (ptys->get_output_handle_nat () =3D=3D orig_output)
		  ptys->set_output_handle_nat (new_output);
	      }
	  if (cygheap->ctty->get_device () =3D=3D get_device ())
	    {
	      fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) cygheap->ctty;
	      if (ptys->get_handle_nat () =3D=3D orig_input)
		ptys->set_handle_nat (new_input);
	      if (ptys->get_output_handle_nat () =3D=3D orig_output)
		ptys->set_output_handle_nat (new_output);
	    }
	  CloseHandle (orig_input);
	  CloseHandle (orig_output);
	}

Both call sites would then collapse to a single line each. This is not a
request to respin; the patch is fine as-is. Just something worth
considering as a follow-up since the duplication is quite substantial
(~20 lines).

Ciao,
Johannes

> Fixes: 8aeb3f3e5037 ("Cygwin: pty: Make apps using console APIs be able =
to debug with gdb.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 53 +++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 9868e88e5..0717c043b 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1118,6 +1118,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void=
)
>  	      else
>  		hand_over_only (get_ttyp ());
>  	      ReleaseMutex (pipe_sw_mutex);
> +
> +	      HANDLE input_handle_nat, output_handle_nat;
>  	      if (need_restore_handles)
>  		{
>  		  pinfo p (get_ttyp ()->master_pid);
> @@ -1125,16 +1127,15 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (vo=
id)
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
> @@ -1154,11 +1155,37 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (vo=
id)
>  		      CloseHandle (repl.to_master); /* not used. */
>  		      CloseHandle (repl.to_slave_nat); /* not used. */
>  		      CloseHandle (repl.to_slave); /* not used. */
> -		      CloseHandle (get_handle_nat ());
> -		      set_handle_nat (repl.from_master_nat);
> -		      CloseHandle (get_output_handle_nat ());
> -		      set_output_handle_nat (repl.to_master_nat);
> +		      input_handle_nat =3D repl.from_master_nat;
> +		      output_handle_nat =3D repl.to_master_nat;
>  		    }
> +
> +		  /* Restore nat handles in all pty slave instances */
> +		  HANDLE orig_input_handle_nat =3D get_handle_nat();
> +		  HANDLE orig_output_handle_nat =3D get_output_handle_nat();
> +		  cygheap_fdenum cfd (false);
> +		  while (cfd.next () >=3D 0)
> +		    if (cfd->get_device () =3D=3D get_device ())
> +		      {
> +			fhandler_base *fh =3D cfd;
> +			fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) fh;
> +			if (ptys->get_handle_nat () =3D=3D orig_input_handle_nat)
> +			  ptys->set_handle_nat (input_handle_nat);
> +			if (ptys->get_output_handle_nat () =3D=3D
> +			    orig_output_handle_nat)
> +			  ptys->set_output_handle_nat (output_handle_nat);
> +		      }
> +		  if (cygheap->ctty->get_device () =3D=3D get_device ())
> +		    {
> +		      fhandler_pty_slave *ptys =3D
> +			(fhandler_pty_slave *) cygheap->ctty;
> +		      if (ptys->get_handle_nat () =3D=3D orig_input_handle_nat)
> +			ptys->set_handle_nat (input_handle_nat);
> +		      if (ptys->get_output_handle_nat () =3D=3D
> +			  orig_output_handle_nat)
> +			ptys->set_output_handle_nat (output_handle_nat);
> +		    }
> +		  CloseHandle (orig_input_handle_nat);
> +		  CloseHandle (orig_output_handle_nat);
>  		}
>  	      myself->exec_dwProcessId =3D 0;
>  	      isHybrid =3D false;
> @@ -3465,7 +3492,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
>  skip_create:
>    do
>      {
> -      /* Fixup handles */
> +      /* Fixup handles in all PTY-slave instances */
>        HANDLE orig_input_handle_nat =3D get_handle_nat ();
>        HANDLE orig_output_handle_nat =3D get_output_handle_nat ();
>        cygheap_fdenum cfd (false);
> @@ -3479,6 +3506,14 @@ skip_create:
>  	    if (ptys->get_output_handle_nat () =3D=3D orig_output_handle_nat)
>  	      ptys->set_output_handle_nat (hpConOut);
>  	  }
> +      if (cygheap->ctty->get_device () =3D=3D get_device ())
> +	{
> +	  fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) cygheap->ctty;
> +	  if (ptys->get_handle_nat () =3D=3D orig_input_handle_nat)
> +	    ptys->set_handle_nat (hpConIn);
> +	  if (ptys->get_output_handle_nat () =3D=3D orig_output_handle_nat)
> +	    ptys->set_output_handle_nat (hpConOut);
> +	}
>        CloseHandle (orig_input_handle_nat);
>        CloseHandle (orig_output_handle_nat);
>      }
> --=20
> 2.51.0
>=20
>=20
>=20
