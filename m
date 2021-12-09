Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by sourceware.org (Postfix) with ESMTPS id 04AB03858C27
 for <cygwin-patches@cygwin.com>; Thu,  9 Dec 2021 23:05:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 04AB03858C27
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1639091130;
 bh=bTd5K0czA4sW1arCvaRnZLsdzNV/q/MDhBYWt7+G7KM=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=NEe1y7wqgpxnv3K1gD3bePH5xmsuuGvD0RQEzMe8HduRtY6Tm9GnxIwUZfT34HzzD
 e+XuWhWv6q9folUXl6OSzVimYBw+eWKCdJeMrkvfl/iDQ5DRXaDZIXTLdtOWdE0v/P
 WJ2U34D0tPEWKgSLuGncW//hnHaInyobUM2ES4DU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1me43H1Flh-00rEdF; Fri, 10
 Dec 2021 00:05:30 +0100
Date: Fri, 10 Dec 2021 00:05:27 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
In-Reply-To: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iSNkdQzz5RCsDoONG42yNzCRNHXQSCYrFEo2QwDZcjqmPCTBaJW
 OWA+PX/IOxN6GQI4av/1yiIVbAW45XCqyuhUFeyzBZkK/DZUWHXRtFtglogQT794lrg4K7G
 BsEHmsBjJniJfDCmOQQ4Dtv2//+vCPh4ONS4pjRwXYyYXQqnKmvD0IvdhMO8DhWE4K09jrV
 UoZ9bm5mG8a92TNIgP93A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uotrgUW4KsQ=:G4g6eQUO7tKBLvGWLblxBQ
 U0A9WEM3wWpxruPjKIIP5xuKkIi1nnUUkFX4bzdfIKqiYgLkxUFqb6eg/FCtmyJVhJ81ISKJp
 7l+v1BZ/L4wXiA6OE6w7d8OxQVG45A2lJI07ejLqg0oU5/W1pB7NX0lpiRnNrC3X2pr/0/sPt
 OpwwbuCx+gtHJhvr1Uaj59IReq8RQ8LpXdbxTAGtBbPir1SEEq9pME1htqD0q4Qb83OmDMOoI
 ywbRI9wkLQL1x22ehwKTrsmetHhe1+25fouM5Wmek5lyWUYfvSSbG6TbDLfu61nyQeUZA9T78
 qWb+WrOh40TEt9yT5KMUBTTmw3kFEcWUsblMaW70pUqAjdE87VrCxTZLJysGYfpW4qxT69scK
 +2DoB0yh/TLJVTxOfaGM9ivbs7kRilGl6OvUP32F+dDJlET+62u6wF2ke1xheAMa8F0tjUXVA
 1LApa9izMf4aYN3IG7RgXc1kjj38t94kN0pJuhxpGGV3WU4IewIR9PmsXvHQcGj+pf/SO76NZ
 19f1C7e68d2bRXCUPT19TSXiME/bH3hg+o04c7fzUbXsNJfOkAdGIN2sabd21lU9bP/yeF4Zo
 POGml3RXjFLmC5DQiw+nlridGaY85qqq3rTVcMQ4SSSFYevZBCo0eP6F8xIYZxdhRgohHiB6j
 nEm5H8NPf7fbVFdsu88DvxbO4g3hAy1As7GuCU4bC86zASeGI4KznaiLIhh6lWiyeb6Tt4rLC
 MAef3zlCf8Z+ZIcq1zXoDvghGsWwJbTWlvJIEYLOTVg7/BmyroGmOZrnjFZuMzqE9PlvN8X2D
 kKPw5r+i153KYy88+hcFVuVklRgZmz8SKpDOdlHjVqcVoqy9oM6NQ8hI4DxrAlBey4GrsdA5b
 GlqQnD30oHPIWLhktb+iK4clwqod3d3kW/O2eyKvWAvT+jDvJmIvqB0LcWUyRnQw6ldaAZo6N
 jeHVaRAwOik+hr9YquXkIxIsHG4caWsGn9gqCxMXXWJX+OePb+feUs2tHV0PnpHFAv534j/J0
 8VRiYHrDLxHHVp/t/a6vp8dCEqHkbz76e4ce4RZysb2BFhJsCH1Jm+v1otWCOpAIg+vdxncec
 Aowd8zzHx74/BU=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 09 Dec 2021 23:05:42 -0000

Hi Takashi,

sorry for responding to a patch you sent almost 10 months ago... but... I
am struggling with it.

First of all, let me describe the problem I am seeing (see also
https://github.com/git-for-windows/git/issues/3579): after upgrading the
MSYS2 runtime to v3.3.3 in Git for Windows, whenever I ask `git.exe` to
spawn `vim.exe` to edit any file, after quitting `vim` I see spurious ANSI
sequences being "ghost-typed" into the terminal (which is a MinTTY running
under `TERM=3Dxterm`).

Apparently the ANSI sequences report the cursor position and the
foreground/background color in response to a CSI [ 6n sent from `vim`.

Clearly, those sequences should go to `vim.exe`, but they mostly don't
arrive there (but in MinTTY instead, as if I had typed them). Sometimes,
the foreground/background color seems to arrive in the `vim` process, but
the cursor position almost always does not. I suspect that it is important
that `git.exe` is a non-MSYS2 process whereas `vim.exe` is an MSYS2
process, and something inside the MSYS2 runtime is at fault.

I've bisected this incorrect behavior to the patch I am replying to.

I tried to trigger the same bug in pure Cygwin (as opposed to MSYS2),
specifically using `disable_pcon` (because MSYS2 defaults to not using the
pseudo console support because I ran into too many issues to be confident
enough in it yet), but I think that Cygwin's `vim` is too old and
therefore might not even send that CSI [ 6n (although `:h t_RV` _does_
show the expected help).

Now, the patch which I am responding to is completely obscure to me. It is
very, very unclear to me whether it really tries to only do one thing
(namely to transfer the input no longer in `read()` but in `setpgid()`),
or rather does many things at once. Even worse, I have not the faintest
clue how this patch is trying to accomplish what the commit message
describes (_because_ it does so many things at once), nor how that could
be related to the observed incorrect behavior, and as a consequence I have
no idea how I can hope to fix said observed incorrect behavior.

Could you help shed some light into the problem?

Thank you,
Johannes

On Thu, 11 Feb 2021, Takashi Yano wrote:

> - Currently, input transfer is performed every time one line is read(),
>   if the non-cygwin app is running in the background. With this patch,
>   transfer is triggered by setpgid() rather than read() so that the
>   unnecessary input transfer can be reduced much in that situation.
> ---
>  winsup/cygwin/fhandler.h      |  15 +-
>  winsup/cygwin/fhandler_tty.cc | 377 ++++++++++++++++++++--------------
>  winsup/cygwin/spawn.cc        |  78 ++++---
>  winsup/cygwin/tty.cc          |  89 ++++++++
>  winsup/cygwin/tty.h           |  16 +-
>  5 files changed, 376 insertions(+), 199 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 2fad7d33c..95011b6e3 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -2244,13 +2244,13 @@ class fhandler_pty_common: public fhandler_termi=
os
>   public:
>    fhandler_pty_common ()
>      : fhandler_termios (),
> -    output_mutex (NULL), input_mutex (NULL),
> +    output_mutex (NULL), input_mutex (NULL), pcon_mutex (NULL),
>      input_available_event (NULL)
>    {
>      pc.file_attributes (FILE_ATTRIBUTE_NORMAL);
>    }
>    static const unsigned pipesize =3D 128 * 1024;
> -  HANDLE output_mutex, input_mutex;
> +  HANDLE output_mutex, input_mutex, pcon_mutex;
>    HANDLE input_available_event;
>
>    bool use_archetype () const {return true;}
> @@ -2306,13 +2306,6 @@ class fhandler_pty_slave: public fhandler_pty_com=
mon
>    void fch_close_handles ();
>
>   public:
> -  /* Transfer direction for transfer_input() */
> -  enum xfer_dir
> -  {
> -    to_nat,
> -    to_cyg
> -  };
> -
>    /* Constructor */
>    fhandler_pty_slave (int);
>
> @@ -2371,8 +2364,8 @@ class fhandler_pty_slave: public fhandler_pty_comm=
on
>    void setup_locale (void);
>    tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
>    void create_invisible_console (void);
> -  static void transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
> -			      _minor_t unit, HANDLE input_available_event);
> +  static void transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp=
,
> +			      HANDLE input_available_event);
>    HANDLE get_input_available_event (void) { return input_available_even=
t; }
>    bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
>  };
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.=
cc
> index 48b89ae77..f6eb3ae4d 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -127,7 +127,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE =
*err, bool iscygwin)
>        if (*err =3D=3D cfd->get_output_handle () ||
>  	  (fd =3D=3D 2 && *err =3D=3D GetStdHandle (STD_ERROR_HANDLE)))
>  	replace_err =3D (fhandler_base *) cfd;
> -      if (cfd->get_major () =3D=3D DEV_PTYS_MAJOR)
> +      if (cfd->get_device () =3D=3D (dev_t) myself->ctty)
>  	{
>  	  fhandler_base *fh =3D cfd;
>  	  fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) fh;
> @@ -154,6 +154,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE =
*err, bool iscygwin)
>  /* CreateProcess() is hooked for GDB etc. */
>  DEF_HOOK (CreateProcessA);
>  DEF_HOOK (CreateProcessW);
> +DEF_HOOK (exit);
>
>  static BOOL WINAPI
>  CreateProcessA_Hooked
> @@ -268,6 +269,34 @@ CreateProcessW_Hooked
>    return ret;
>  }
>
> +void
> +exit_Hooked (int e)
> +{
> +  if (isHybrid)
> +    {
> +      cygheap_fdenum cfd (false);
> +      while (cfd.next () >=3D 0)
> +	if (cfd->get_device () =3D=3D (dev_t) myself->ctty)
> +	  {
> +	    fhandler_base *fh =3D cfd;
> +	    fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) fh;
> +	    tty *ttyp =3D ptys->get_ttyp ();
> +	    HANDLE from =3D ptys->get_handle ();
> +	    HANDLE input_available_event =3D ptys->get_input_available_event (=
);
> +	    if (ttyp->getpgid () =3D=3D myself->pgid
> +		&& ttyp->pcon_input_state_eq (tty::to_nat))
> +	      {
> +		WaitForSingleObject (ptys->input_mutex, INFINITE);
> +		fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
> +						    input_available_event);
> +		ReleaseMutex (ptys->input_mutex);
> +	      }
> +	    break;
> +	  }
> +    }
> +  exit_Orig (e);
> +}
> +
>  static void
>  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
>  		UINT cp_from, const char *ptr_from, size_t len_from,
> @@ -438,7 +467,8 @@ fhandler_pty_master::accept_input ()
>
>    HANDLE write_to =3D get_output_handle ();
>    tmp_pathbuf tp;
> -  if (to_be_read_from_pcon ())
> +  if (to_be_read_from_pcon ()
> +      && get_ttyp ()->pcon_input_state =3D=3D tty::to_nat)
>      {
>        write_to =3D to_slave;
>
> @@ -487,11 +517,27 @@ fhandler_pty_master::accept_input ()
>      }
>    else
>      {
> -      DWORD rc;
> +      BOOL rc =3D TRUE;
>        DWORD written =3D 0;
>
>        paranoid_printf ("about to write %u chars to slave", bytes_left);
> -      rc =3D WriteFile (write_to, p, bytes_left, &written, NULL);
> +      /* Write line by line for transfer input. */
> +      char *p0 =3D p;
> +      char *p1 =3D p;
> +      DWORD n;
> +      while ((p1 =3D (char *) memchr (p0, '\n', bytes_left - (p0 - p)))
> +	     || (p1 =3D (char *) memchr (p0, '\r', bytes_left - (p0 - p))))
> +	{
> +	  n =3D p1 - p0 + 1;
> +	  rc =3D WriteFile (write_to, p0, n, &n, NULL);
> +	  written +=3D n;
> +	  p0 =3D p1 + 1;
> +	}
> +      if ((n =3D bytes_left - (p0 - p)))
> +	{
> +	  rc =3D WriteFile (write_to, p0, n, &n, NULL);
> +	  written +=3D n;
> +	}
>        if (!rc)
>  	{
>  	  debug_printf ("error writing to pipe %p %E", write_to);
> @@ -669,7 +715,7 @@ fhandler_pty_slave::open (int flags, mode_t)
>    {
>      &from_master_local, &input_available_event, &input_mutex, &inuse,
>      &output_mutex, &to_master_local, &pty_owner, &to_master_cyg_local,
> -    &from_master_cyg_local,
> +    &from_master_cyg_local, &pcon_mutex,
>      NULL
>    };
>
> @@ -697,6 +743,11 @@ fhandler_pty_slave::open (int flags, mode_t)
>        errmsg =3D "open input mutex failed, %E";
>        goto err;
>      }
> +  if (!(pcon_mutex =3D get_ttyp ()->open_mutex (PCON_MUTEX, MAXIMUM_ALL=
OWED)))
> +    {
> +      errmsg =3D "open pcon mutex failed, %E";
> +      goto err;
> +    }
>    shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
>    if (!(input_available_event =3D OpenEvent (MAXIMUM_ALLOWED, TRUE, buf=
)))
>      {
> @@ -960,12 +1011,19 @@ fhandler_pty_slave::set_switch_to_pcon (void)
>      {
>        isHybrid =3D true;
>        setup_locale ();
> +      myself->exec_dwProcessId =3D myself->dwProcessId;
>        bool nopcon =3D (disable_pcon || !term_has_pcon_cap (NULL));
> -      if (!setup_pseudoconsole (nopcon))
> -	fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
> -					    get_handle_cyg (),
> -					    get_ttyp (), get_minor (),
> -					    input_available_event);
> +      WaitForSingleObject (pcon_mutex, INFINITE);
> +      bool pcon_enabled =3D setup_pseudoconsole (nopcon);
> +      ReleaseMutex (pcon_mutex);
> +      if (!pcon_enabled && get_ttyp ()->getpgid () =3D=3D myself->pgid
> +	  && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
> +	{
> +	  WaitForSingleObject (input_mutex, INFINITE);
> +	  transfer_input (tty::to_nat, get_handle_cyg (), get_ttyp (),
> +			  input_available_event);
> +	  ReleaseMutex (input_mutex);
> +	}
>      }
>  }
>
> @@ -985,19 +1043,24 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
>  	  h_gdb_process =3D NULL;
>  	  if (isHybrid)
>  	    {
> -	      if (get_ttyp ()->switch_to_pcon_in
> -		  && get_ttyp ()->pcon_pid =3D=3D myself->pid)
> -		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
> -						    get_handle (),
> -						    get_ttyp (), get_minor (),
> -						    input_available_event);
> -	      if (get_ttyp ()->master_is_running_as_service)
> +	      if (get_ttyp ()->getpgid () =3D=3D myself->pgid
> +		  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
> +		{
> +		  WaitForSingleObject (input_mutex, INFINITE);
> +		  transfer_input (tty::to_cyg, get_handle (), get_ttyp (),
> +				  input_available_event);
> +		  ReleaseMutex (input_mutex);
> +		}
> +	      if (get_ttyp ()->master_is_running_as_service
> +		  && get_ttyp ()->pcon_activated)
>  		/* If the master is running as service, re-attaching to
>  		   the console of the parent process will fail.
>  		   Therefore, never close pseudo console here. */
>  		return;
>  	      bool need_restore_handles =3D get_ttyp ()->pcon_activated;
> +	      WaitForSingleObject (pcon_mutex, INFINITE);
>  	      close_pseudoconsole (get_ttyp ());
> +	      ReleaseMutex (pcon_mutex);
>  	      if (need_restore_handles)
>  		{
>  		  pinfo p (get_ttyp ()->master_pid);
> @@ -1047,6 +1110,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
>  		  if (fix_err)
>  		    SetStdHandle (STD_ERROR_HANDLE, get_output_handle ());
>  		}
> +	      myself->exec_dwProcessId =3D 0;
>  	      isHybrid =3D false;
>  	    }
>  	}
> @@ -1057,11 +1121,6 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
>      return;
>    if (isHybrid)
>      return;
> -  if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated)
> -    fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
> -					get_handle (),
> -					get_ttyp (), get_minor (),
> -					input_available_event);
>    get_ttyp ()->pcon_pid =3D 0;
>    get_ttyp ()->switch_to_pcon_in =3D false;
>    get_ttyp ()->pcon_activated =3D false;
> @@ -1119,77 +1178,47 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool=
 mask, bool xfer)
>    else if (InterlockedDecrement (&num_reader) =3D=3D 0)
>      CloseHandle (slave_reading);
>
> -  if (get_ttyp ()->switch_to_pcon_in && !!masked !=3D mask && xfer)
> -    { /* Transfer input */
> -      bool attach_restore =3D false;
> -      DWORD pcon_winpid =3D 0;
> -      if (get_ttyp ()->pcon_pid)
> -	{
> -	  pinfo p (get_ttyp ()->pcon_pid);
> -	  if (p)
> -	    pcon_winpid =3D p->exec_dwProcessId ?: p->dwProcessId;
> -	}
> -      if (mask)
> -	{
> -	  HANDLE from =3D get_handle ();
> -	  if (get_ttyp ()->pcon_activated && pcon_winpid
> -	      && !get_console_process_id (pcon_winpid, true))
> -	    {
> -	      HANDLE pcon_owner =3D
> -		OpenProcess (PROCESS_DUP_HANDLE, FALSE, pcon_winpid);
> -	      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> -			       GetCurrentProcess (), &from,
> -			       0, TRUE, DUPLICATE_SAME_ACCESS);
> -	      CloseHandle (pcon_owner);
> -	      FreeConsole ();
> -	      AttachConsole (pcon_winpid);
> -	      attach_restore =3D true;
> -	    }
> -	  fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
> -					      from,
> -					      get_ttyp (), get_minor (),
> -					      input_available_event);
> -	}
> -      else
> +  /* In GDB, transfer input based on setpgid() does not work because
> +     GDB may not set terminal process group properly. Therefore,
> +     transfer input here if isHybrid is set. */
> +  if (get_ttyp ()->switch_to_pcon_in && !!masked !=3D mask && xfer && i=
sHybrid)
> +    {
> +      if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
>  	{
> -	  if (get_ttyp ()->pcon_activated && pcon_winpid
> -	      && !get_console_process_id (pcon_winpid, true))
> -	    {
> -	      FreeConsole ();
> -	      AttachConsole (pcon_winpid);
> -	      attach_restore =3D true;
> -	    }
> -	  fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
> -					      get_handle_cyg (),
> -					      get_ttyp (), get_minor (),
> -					      input_available_event);
> +	  WaitForSingleObject (input_mutex, INFINITE);
> +	  transfer_input (tty::to_cyg, get_handle (), get_ttyp (),
> +			  input_available_event);
> +	  ReleaseMutex (input_mutex);
>  	}
> -      if (attach_restore)
> +      else if (!mask && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
>  	{
> -	  FreeConsole ();
> -	  pinfo p (myself->ppid);
> -	  if (p)
> -	    {
> -	      if (!AttachConsole (p->dwProcessId))
> -		AttachConsole (ATTACH_PARENT_PROCESS);
> -	    }
> -	  else
> -	    AttachConsole (ATTACH_PARENT_PROCESS);
> +	  WaitForSingleObject (input_mutex, INFINITE);
> +	  transfer_input (tty::to_nat, get_handle_cyg (), get_ttyp (),
> +			  input_available_event);
> +	  ReleaseMutex (input_mutex);
>  	}
>      }
> -  return;
>  }
>
>  bool
>  fhandler_pty_master::to_be_read_from_pcon (void)
>  {
> +  if (!get_ttyp ()->switch_to_pcon_in)
> +    return false;
> +
>    char name[MAX_PATH];
>    shared_name (name, TTY_SLAVE_READING, get_minor ());
>    HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
>    CloseHandle (masked);
>
> -  return get_ttyp ()->pcon_start
> -    || (get_ttyp ()->switch_to_pcon_in && !masked);
> +  if (masked) /* The foreground process is cygwin process */
> +    return false;
> +
> +  if (!pinfo (get_ttyp ()->getpgid ()))
> +    /* GDB may set invalid process group for non-cygwin process. */
> +    return true;
> +
> +  return get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ());
>  }
>
>  void __reg3
> @@ -1720,6 +1749,7 @@ fhandler_pty_slave::fch_open_handles (bool chown)
>  				     TRUE, buf);
>    output_mutex =3D get_ttyp ()->open_output_mutex (write_access);
>    input_mutex =3D get_ttyp ()->open_input_mutex (write_access);
> +  pcon_mutex =3D get_ttyp ()->open_mutex (PCON_MUTEX, write_access);
>    inuse =3D get_ttyp ()->open_inuse (write_access);
>    if (!input_available_event || !output_mutex || !input_mutex || !inuse=
)
>      {
> @@ -1873,6 +1903,8 @@ fhandler_pty_common::close ()
>  		  get_minor (), get_handle (), get_output_handle ());
>    if (!ForceCloseHandle (input_mutex))
>      termios_printf ("CloseHandle (input_mutex<%p>), %E", input_mutex);
> +  if (!ForceCloseHandle (pcon_mutex))
> +    termios_printf ("CloseHandle (pcon_mutex<%p>), %E", pcon_mutex);
>    if (!ForceCloseHandle1 (get_handle (), from_pty))
>      termios_printf ("CloseHandle (get_handle ()<%p>), %E", get_handle (=
));
>    if (!ForceCloseHandle1 (get_output_handle (), to_pty))
> @@ -2011,72 +2043,103 @@ fhandler_pty_master::write (const void *ptr, si=
ze_t len)
>
>    push_process_state process_state (PID_TTYOU);
>
> -  /* Write terminal input to to_slave pipe instead of output_handle
> -     if current application is native console application. */
> -  if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated)
> +  if (get_ttyp ()->pcon_start)
>      {
> -      tmp_pathbuf tp;
> -      char *buf =3D (char *) ptr;
> -      size_t nlen =3D len;
> -      if (get_ttyp ()->term_code_page !=3D CP_UTF8)
> -	{
> -	  static mbstate_t mbp;
> -	  buf =3D tp.c_get ();
> -	  nlen =3D NT_MAX_PATH;
> -	  convert_mb_str (CP_UTF8, buf, &nlen,
> -			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> -			  &mbp);
> -	}
> +      /* Pseudo condole support uses "CSI6n" to get cursor position.
> +	 If the reply for "CSI6n" is divided into multiple writes,
> +	 pseudo console sometimes does not recognize it.  Therefore,
> +	 put them together into wpbuf and write all at once. */
> +      static const int wpbuf_len =3D strlen ("\033[32768;32868R");
> +      static char wpbuf[wpbuf_len];
> +      static int ixput =3D 0;
> +      static int state =3D 0;
>
> +      DWORD n;
>        WaitForSingleObject (input_mutex, INFINITE);
> -
> -      DWORD wLen;
> -
> -      if (get_ttyp ()->pcon_start)
> +      for (size_t i =3D 0; i < len; i++)
>  	{
> -	  /* Pseudo condole support uses "CSI6n" to get cursor position.
> -	     If the reply for "CSI6n" is divided into multiple writes,
> -	     pseudo console sometimes does not recognize it.  Therefore,
> -	     put them together into wpbuf and write all at once. */
> -	  static const int wpbuf_len =3D 64;
> -	  static char wpbuf[wpbuf_len];
> -	  static int ixput =3D 0;
> -
> -	  if (ixput + nlen < wpbuf_len)
> +	  if (p[i] =3D=3D '\033')
>  	    {
> -	      memcpy (wpbuf + ixput, buf, nlen);
> -	      ixput +=3D nlen;
> -	    }
> -	  else
> -	    {
> -	      WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
> +	      if (ixput)
> +		line_edit (wpbuf, ixput, ti, &ret);
>  	      ixput =3D 0;
> -	      get_ttyp ()->pcon_start =3D false;
> -	      WriteFile (to_slave, buf, nlen, &wLen, NULL);
> +	      state =3D 1;
>  	    }
> -	  if (ixput && memchr (wpbuf, 'R', ixput))
> +	  if (state =3D=3D 1)
>  	    {
> -	      WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
> -	      ixput =3D 0;
> -	      get_ttyp ()->pcon_start =3D false;
> +	      if (ixput < wpbuf_len)
> +		wpbuf[ixput++] =3D p[i];
> +	      else
> +		{
> +		  if (!get_ttyp ()->req_xfer_input)
> +		    WriteFile (to_slave, wpbuf, ixput, &n, NULL);
> +		  ixput =3D 0;
> +		  wpbuf[ixput++] =3D p[i];
> +		}
>  	    }
> -	  ReleaseMutex (input_mutex);
> -	  if (get_ttyp ()->switch_to_pcon_in)
> +	  else
> +	    line_edit (p + i, 1, ti, &ret);
> +	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
> +	    state =3D 2;
> +	}
> +      if (state =3D=3D 2)
> +	{
> +	  if (!get_ttyp ()->req_xfer_input)
> +	    WriteFile (to_slave, wpbuf, ixput, &n, NULL);
> +	  ixput =3D 0;
> +	  state =3D 0;
> +	  get_ttyp ()->req_xfer_input =3D false;
> +	  get_ttyp ()->pcon_start =3D false;
> +	}
> +      ReleaseMutex (input_mutex);
> +
> +      if (!get_ttyp ()->pcon_start)
> +	{
> +	  pinfo pp (get_ttyp ()->pcon_start_pid);
> +	  bool pcon_fg =3D (pp && get_ttyp ()->getpgid () =3D=3D pp->pgid);
> +	  /* GDB may set WINPID rather than cygwin PID to process group
> +	     when the debugged process is a non-cygwin process.*/
> +	  pcon_fg |=3D !pinfo (get_ttyp ()->getpgid ());
> +	  if (get_ttyp ()->switch_to_pcon_in && pcon_fg
> +	      && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
>  	    {
> -	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
> -						  from_master_cyg,
> -						  get_ttyp (), get_minor (),
> -						  input_available_event);
>  	      /* This accept_input() call is needed in order to transfer input
>  		 which is not accepted yet to non-cygwin pipe. */
>  	      if (get_readahead_valid ())
>  		accept_input ();
> +	      WaitForSingleObject (input_mutex, INFINITE);
> +	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master_cyg=
,
> +						  get_ttyp (),
> +						  input_available_event);
> +	      ReleaseMutex (input_mutex);
>  	    }
> -	  return len;
> +	  get_ttyp ()->pcon_start_pid =3D 0;
>  	}
>
> -      WriteFile (to_slave, buf, nlen, &wLen, NULL);
> +      return len;
> +    }
> +
> +  /* Write terminal input to to_slave pipe instead of output_handle
> +     if current application is native console application. */
> +  if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated
> +      && get_ttyp ()->pcon_input_state =3D=3D tty::to_nat)
> +    {
> +      tmp_pathbuf tp;
> +      char *buf =3D (char *) ptr;
> +      size_t nlen =3D len;
> +      if (get_ttyp ()->term_code_page !=3D CP_UTF8)
> +	{
> +	  static mbstate_t mbp;
> +	  buf =3D tp.c_get ();
> +	  nlen =3D NT_MAX_PATH;
> +	  convert_mb_str (CP_UTF8, buf, &nlen,
> +			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> +			  &mbp);
> +	}
>
> +      WaitForSingleObject (input_mutex, INFINITE);
> +      DWORD n;
> +      WriteFile (to_slave, buf, nlen, &n, NULL);
>        ReleaseMutex (input_mutex);
>
>        return len;
> @@ -2248,6 +2311,8 @@ fhandler_pty_slave::fixup_after_exec ()
>    /* CreateProcess() is hooked for GDB etc. */
>    DO_HOOK (NULL, CreateProcessA);
>    DO_HOOK (NULL, CreateProcessW);
> +  if (CreateProcessA_Orig || CreateProcessW_Orig)
> +    DO_HOOK (NULL, exit);
>  }
>
>  /* This thread function handles the master control pipe.  It waits for =
a
> @@ -2739,6 +2804,10 @@ fhandler_pty_master::setup ()
>    if (!(input_mutex =3D CreateMutex (&sa, FALSE, buf)))
>      goto err;
>
> +  errstr =3D shared_name (buf, PCON_MUTEX, unit);
> +  if (!(pcon_mutex =3D CreateMutex (&sa, FALSE, buf)))
> +    goto err;
> +
>    attach_mutex =3D CreateMutex (&sa, FALSE, NULL);
>
>    /* Create master control pipe which allows the master to duplicate
> @@ -2980,10 +3049,17 @@ fhandler_pty_slave::setup_pseudoconsole (bool no=
pcon)
>      }
>
>    HANDLE hpConIn, hpConOut;
> -  acquire_output_mutex (INFINITE);
>    if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid !=3D myself->pid
>        && !!pinfo (get_ttyp ()->pcon_pid) && get_ttyp ()->pcon_activated=
)
>      {
> +      /* Send CSI6n just for requesting transfer input. */
> +      DWORD n;
> +      WaitForSingleObject (input_mutex, INFINITE);
> +      get_ttyp ()->req_xfer_input =3D true;
> +      get_ttyp ()->pcon_start =3D true;
> +      get_ttyp ()->pcon_start_pid =3D myself->pid;
> +      WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
> +      ReleaseMutex (input_mutex);
>        /* Attach to the pseudo console which already exits. */
>        pinfo p (get_ttyp ()->pcon_pid);
>        HANDLE pcon_owner =3D
> @@ -3068,8 +3144,9 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopc=
on)
>        si.StartupInfo.hStdOutput =3D NULL;
>        si.StartupInfo.hStdError =3D NULL;
>
> -      get_ttyp ()->pcon_start =3D true;
>        get_ttyp ()->pcon_activated =3D true;
> +      get_ttyp ()->pcon_start =3D true;
> +      get_ttyp ()->pcon_start_pid =3D myself->pid;
>        if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
>  			   TRUE, EXTENDED_STARTUPINFO_PRESENT,
>  			   NULL, NULL, &si.StartupInfo, &pi))
> @@ -3183,7 +3260,6 @@ skip_create:
>    if (get_ttyp ()->previous_output_code_page)
>      SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
>
> -  release_output_mutex ();
>    return true;
>
>  cleanup_pcon_in:
> @@ -3196,6 +3272,7 @@ cleanup_helper_process:
>  cleanup_event_and_pipes:
>    CloseHandle (hello);
>    get_ttyp ()->pcon_start =3D false;
> +  get_ttyp ()->pcon_start_pid =3D 0;
>    get_ttyp ()->pcon_activated =3D false;
>  skip_close_hello:
>    CloseHandle (goodbye);
> @@ -3212,7 +3289,6 @@ cleanup_pseudo_console:
>        CloseHandle (tmp);
>      }
>  fallback:
> -  release_output_mutex ();
>    return false;
>  }
>
> @@ -3312,6 +3388,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp=
)
>  	      ttyp->switch_to_pcon_in =3D false;
>  	      ttyp->pcon_pid =3D 0;
>  	      ttyp->pcon_start =3D false;
> +	      ttyp->pcon_start_pid =3D 0;
>  	    }
>  	}
>        else
> @@ -3429,7 +3506,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR=
 *env)
>    /* Set pcon_activated and pcon_start so that the response
>       will sent to io_handle rather than io_handle_cyg. */
>    get_ttyp ()->pcon_activated =3D true;
> -  get_ttyp ()->pcon_pid =3D myself->pid;
>    /* pcon_start will be cleared in master write() when CSI6n is respond=
ed. */
>    get_ttyp ()->pcon_start =3D true;
>    WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
> @@ -3526,11 +3602,11 @@ fhandler_pty_master::get_master_fwd_thread_param=
 (master_fwd_thread_param_t *p)
>  #define ALT_PRESSED (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)
>  #define CTRL_PRESSED (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED)
>  void
> -fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *tty=
p,
> -				    _minor_t unit, HANDLE input_available_event)
> +fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty=
 *ttyp,
> +				    HANDLE input_available_event)
>  {
>    HANDLE to;
> -  if (dir =3D=3D to_nat)
> +  if (dir =3D=3D tty::to_nat)
>      to =3D ttyp->to_slave ();
>    else
>      to =3D ttyp->to_slave_cyg ();
> @@ -3548,14 +3624,14 @@ fhandler_pty_slave::transfer_input (xfer_dir dir=
, HANDLE from, tty *ttyp,
>        char pipe[MAX_PATH];
>        __small_sprintf (pipe,
>  		       "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
> -		       &cygheap->installation_key, unit);
> +		       &cygheap->installation_key, ttyp->get_minor ());
>        pipe_request req =3D { GetCurrentProcessId () };
>        pipe_reply repl;
>        DWORD len;
>        if (!CallNamedPipe (pipe, &req, sizeof req,
>  			  &repl, sizeof repl, &len, 500))
>  	return; /* What can we do? */
> -      if (dir =3D=3D to_nat)
> +      if (dir =3D=3D tty::to_nat)
>  	to =3D repl.to_slave;
>        else
>  	to =3D repl.to_slave_cyg;
> @@ -3563,7 +3639,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, =
HANDLE from, tty *ttyp,
>
>    UINT cp_from =3D 0, cp_to =3D 0;
>
> -  if (dir =3D=3D to_nat)
> +  if (dir =3D=3D tty::to_nat)
>      {
>        cp_from =3D ttyp->term_code_page;
>        if (ttyp->pcon_activated)
> @@ -3582,7 +3658,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, =
HANDLE from, tty *ttyp,
>
>    bool transfered =3D false;
>
> -  if (dir =3D=3D to_cyg && ttyp->pcon_activated)
> +  if (dir =3D=3D tty::to_cyg && ttyp->pcon_activated)
>      { /* from handle is console handle */
>        INPUT_RECORD r[INREC_SIZE];
>        DWORD n;
> @@ -3607,18 +3683,6 @@ fhandler_pty_slave::transfer_input (xfer_dir dir,=
 HANDLE from, tty *ttyp,
>  			 && (ctrl_key_state & CTRL_PRESSED)
>  			 && !(ctrl_key_state & ALT_PRESSED))
>  		  buf[len++] =3D '\0';
> -		else if (r[i].Event.KeyEvent.wVirtualKeyCode =3D=3D VK_F3)
> -		  {
> -		    /* If the cursor position report for CSI6n matches
> -		       with e.g. "ESC[1;2R", pseudo console translates
> -		       it to Shift-F3. This is a workaround for that. */
> -		    int ctrl =3D 1;
> -		    if (ctrl_key_state & SHIFT_PRESSED) ctrl +=3D 1;
> -		    if (ctrl_key_state & ALT_PRESSED) ctrl +=3D 2;
> -		    if (ctrl_key_state & CTRL_PRESSED) ctrl +=3D 4;
> -		    __small_sprintf (buf + len, "\033[1;%1dR", ctrl);
> -		    len +=3D 6;
> -		  }
>  		else
>  		  { /* arrow/function keys */
>  		    /* FIXME: The current code generates cygwin terminal
> @@ -3666,11 +3730,15 @@ fhandler_pty_slave::transfer_input (xfer_dir dir=
, HANDLE from, tty *ttyp,
>  	  DWORD n =3D MIN (bytes_in_pipe, NT_MAX_PATH);
>  	  ReadFile (from, buf, n, &n, NULL);
>  	  char *ptr =3D buf;
> -	  if (dir =3D=3D to_nat && ttyp->pcon_activated)
> +	  if (dir =3D=3D tty::to_nat)
>  	    {
>  	      char *p =3D buf;
> -	      while ((p =3D (char *) memchr (p, '\n', n - (p - buf))))
> -		*p =3D '\r';
> +	      if (ttyp->pcon_activated)
> +		while ((p =3D (char *) memchr (p, '\n', n - (p - buf))))
> +		  *p =3D '\r';
> +	      else
> +		while ((p =3D (char *) memchr (p, '\r', n - (p - buf))))
> +		  *p =3D '\n';
>  	    }
>  	  if (cp_to !=3D cp_from)
>  	    {
> @@ -3686,8 +3754,9 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, =
HANDLE from, tty *ttyp,
>  	}
>      }
>
> -  if (dir =3D=3D to_nat)
> +  if (dir =3D=3D tty::to_nat)
>      ResetEvent (input_available_event);
>    else if (transfered)
>      SetEvent (input_available_event);
> +  ttyp->pcon_input_state =3D dir;
>  }
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index c4b612815..4d4d599ca 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -656,18 +656,19 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>        bool enable_pcon =3D false;
>        HANDLE ptys_from_master =3D NULL;
>        HANDLE ptys_input_available_event =3D NULL;
> -      HANDLE ptys_output_mutex =3D NULL;
> +      HANDLE ptys_pcon_mutex =3D NULL;
> +      HANDLE ptys_input_mutex =3D NULL;
>        tty *ptys_ttyp =3D NULL;
> -      _minor_t ptys_unit =3D 0;
>        if (!iscygwin () && ptys_primary && is_console_app (runpath))
>  	{
>  	  bool nopcon =3D mode !=3D _P_OVERLAY && mode !=3D _P_WAIT;
>  	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
>  	    nopcon =3D true;
> +	  ptys_ttyp =3D ptys_primary->get_ttyp ();
> +	  WaitForSingleObject (ptys_primary->pcon_mutex, INFINITE);
>  	  if (ptys_primary->setup_pseudoconsole (nopcon))
>  	    enable_pcon =3D true;
> -	  ptys_ttyp =3D ptys_primary->get_ttyp ();
> -	  ptys_unit =3D ptys_primary->get_minor ();
> +	  ReleaseMutex (ptys_primary->pcon_mutex);
>  	  ptys_from_master =3D ptys_primary->get_handle ();
>  	  DuplicateHandle (GetCurrentProcess (), ptys_from_master,
>  			   GetCurrentProcess (), &ptys_from_master,
> @@ -677,14 +678,21 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>  	  DuplicateHandle (GetCurrentProcess (), ptys_input_available_event,
>  			   GetCurrentProcess (), &ptys_input_available_event,
>  			   0, 0, DUPLICATE_SAME_ACCESS);
> -	  DuplicateHandle (GetCurrentProcess (), ptys_primary->output_mutex,
> -			   GetCurrentProcess (), &ptys_output_mutex,
> +	  DuplicateHandle (GetCurrentProcess (), ptys_primary->pcon_mutex,
> +			   GetCurrentProcess (), &ptys_pcon_mutex,
> +			   0, 0, DUPLICATE_SAME_ACCESS);
> +	  DuplicateHandle (GetCurrentProcess (), ptys_primary->input_mutex,
> +			   GetCurrentProcess (), &ptys_input_mutex,
>  			   0, 0, DUPLICATE_SAME_ACCESS);
> -	  if (!enable_pcon)
> -	    fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
> -						ptys_primary->get_handle_cyg (),
> -						ptys_ttyp, ptys_unit,
> -						ptys_input_available_event);
> +	  if (!enable_pcon && ptys_ttyp->getpgid () =3D=3D myself->pgid
> +	      && ptys_ttyp->pcon_input_state_eq (tty::to_cyg))
> +	    {
> +	      WaitForSingleObject (ptys_input_mutex, INFINITE);
> +	      fhandler_pty_slave::transfer_input (tty::to_nat,
> +				    ptys_primary->get_handle_cyg (),
> +				    ptys_ttyp, ptys_input_available_event);
> +	      ReleaseMutex (ptys_input_mutex);
> +	    }
>  	}
>
>        /* Set up needed handles for stdio */
> @@ -969,20 +977,22 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>  	  if (ptys_ttyp)
>  	    {
>  	      ptys_ttyp->wait_pcon_fwd ();
> -	      /* Do not transfer input if another process using pseudo
> -		 console exists. */
> -	      WaitForSingleObject (ptys_output_mutex, INFINITE);
> -	      if (!fhandler_pty_common::get_console_process_id
> -			      (myself->exec_dwProcessId, false, true, true))
> -		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
> -						    ptys_from_master,
> -						    ptys_ttyp, ptys_unit,
> -						    ptys_input_available_event);
> +	      if (ptys_ttyp->getpgid () =3D=3D myself->pgid
> +		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
> +		{
> +		  WaitForSingleObject (ptys_input_mutex, INFINITE);
> +		  fhandler_pty_slave::transfer_input (tty::to_cyg,
> +					    ptys_from_master, ptys_ttyp,
> +					    ptys_input_available_event);
> +		  ReleaseMutex (ptys_input_mutex);
> +		}
>  	      CloseHandle (ptys_from_master);
> +	      CloseHandle (ptys_input_mutex);
>  	      CloseHandle (ptys_input_available_event);
> +	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
>  	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
> -	      ReleaseMutex (ptys_output_mutex);
> -	      CloseHandle (ptys_output_mutex);
> +	      ReleaseMutex (ptys_pcon_mutex);
> +	      CloseHandle (ptys_pcon_mutex);
>  	    }
>  	  if (cons_native)
>  	    {
> @@ -1002,20 +1012,22 @@ child_info_spawn::worker (const char *prog_arg, =
const char *const *argv,
>  	  if (ptys_ttyp)
>  	    {
>  	      ptys_ttyp->wait_pcon_fwd ();
> -	      /* Do not transfer input if another process using pseudo
> -		 console exists. */
> -	      WaitForSingleObject (ptys_output_mutex, INFINITE);
> -	      if (!fhandler_pty_common::get_console_process_id
> -			      (myself->exec_dwProcessId, false, true, true))
> -		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
> -						    ptys_from_master,
> -						    ptys_ttyp, ptys_unit,
> -						    ptys_input_available_event);
> +	      if (ptys_ttyp->getpgid () =3D=3D myself->pgid
> +		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
> +		{
> +		  WaitForSingleObject (ptys_input_mutex, INFINITE);
> +		  fhandler_pty_slave::transfer_input (tty::to_cyg,
> +					    ptys_from_master, ptys_ttyp,
> +					    ptys_input_available_event);
> +		  ReleaseMutex (ptys_input_mutex);
> +		}
>  	      CloseHandle (ptys_from_master);
> +	      CloseHandle (ptys_input_mutex);
>  	      CloseHandle (ptys_input_available_event);
> +	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
>  	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
> -	      ReleaseMutex (ptys_output_mutex);
> -	      CloseHandle (ptys_output_mutex);
> +	      ReleaseMutex (ptys_pcon_mutex);
> +	      CloseHandle (ptys_pcon_mutex);
>  	    }
>  	  if (cons_native)
>  	    {
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index fb4501c1b..41f81f694 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -241,6 +241,7 @@ tty::init ()
>    term_code_page =3D 0;
>    pcon_last_time =3D 0;
>    pcon_start =3D false;
> +  pcon_start_pid =3D 0;
>    pcon_cap_checked =3D false;
>    has_csi6n =3D false;
>    need_invisible_console =3D false;
> @@ -248,6 +249,8 @@ tty::init ()
>    previous_code_page =3D 0;
>    previous_output_code_page =3D 0;
>    master_is_running_as_service =3D false;
> +  req_xfer_input =3D false;
> +  pcon_input_state =3D to_cyg;
>  }
>
>  HANDLE
> @@ -293,6 +296,77 @@ tty_min::ttyname ()
>    return d.name ();
>  }
>
> +void
> +tty_min::setpgid (int pid)
> +{
> +  fhandler_pty_slave *ptys =3D NULL;
> +  cygheap_fdenum cfd (false);
> +  while (cfd.next () >=3D 0 && ptys =3D=3D NULL)
> +    if (cfd->get_device () =3D=3D getntty ())
> +      ptys =3D (fhandler_pty_slave *) (fhandler_base *) cfd;
> +
> +  if (ptys)
> +    {
> +      tty *ttyp =3D ptys->get_ttyp ();
> +      WaitForSingleObject (ptys->pcon_mutex, INFINITE);
> +      bool was_pcon_fg =3D ttyp->pcon_fg (pgid);
> +      bool pcon_fg =3D ttyp->pcon_fg (pid);
> +      if (!was_pcon_fg && pcon_fg && ttyp->switch_to_pcon_in
> +	  && ttyp->pcon_input_state_eq (tty::to_cyg))
> +	{
> +	WaitForSingleObject (ptys->input_mutex, INFINITE);
> +	fhandler_pty_slave::transfer_input (tty::to_nat,
> +					    ptys->get_handle_cyg (), ttyp,
> +					    ptys->get_input_available_event ());
> +	ReleaseMutex (ptys->input_mutex);
> +	}
> +      else if (was_pcon_fg && !pcon_fg && ttyp->switch_to_pcon_in
> +	       && ttyp->pcon_input_state_eq (tty::to_nat))
> +	{
> +	  bool attach_restore =3D false;
> +	  DWORD pcon_winpid =3D 0;
> +	  if (ttyp->pcon_pid)
> +	    {
> +	      pinfo p (ttyp->pcon_pid);
> +	      if (p)
> +		pcon_winpid =3D p->exec_dwProcessId ?: p->dwProcessId;
> +	    }
> +	  HANDLE from =3D ptys->get_handle ();
> +	  if (ttyp->pcon_activated && pcon_winpid
> +	      && !ptys->get_console_process_id (pcon_winpid, true))
> +	    {
> +	      HANDLE pcon_owner =3D
> +		OpenProcess (PROCESS_DUP_HANDLE, FALSE, pcon_winpid);
> +	      DuplicateHandle (pcon_owner, ttyp->h_pcon_in,
> +			       GetCurrentProcess (), &from,
> +			       0, TRUE, DUPLICATE_SAME_ACCESS);
> +	      CloseHandle (pcon_owner);
> +	      FreeConsole ();
> +	      AttachConsole (pcon_winpid);
> +	      attach_restore =3D true;
> +	    }
> +	  WaitForSingleObject (ptys->input_mutex, INFINITE);
> +	  fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
> +				  ptys->get_input_available_event ());
> +	  ReleaseMutex (ptys->input_mutex);
> +	  if (attach_restore)
> +	    {
> +	      FreeConsole ();
> +	      pinfo p (myself->ppid);
> +	      if (p)
> +		{
> +		  if (!AttachConsole (p->dwProcessId))
> +		    AttachConsole (ATTACH_PARENT_PROCESS);
> +		}
> +	      else
> +		AttachConsole (ATTACH_PARENT_PROCESS);
> +	    }
> +	}
> +      ReleaseMutex (ptys->pcon_mutex);
> +    }
> +  pgid =3D pid;
> +}
> +
>  void
>  tty::wait_pcon_fwd (bool init)
>  {
> @@ -312,3 +386,18 @@ tty::wait_pcon_fwd (bool init)
>        cygwait (tw);
>      }
>  }
> +
> +bool
> +tty::pcon_fg (pid_t pgid)
> +{
> +  /* Check if the terminal pgid matches with the pgid of the
> +     non-cygwin process. */
> +  winpids pids ((DWORD) 0);
> +  for (unsigned i =3D 0; i < pids.npids; i++)
> +    {
> +      _pinfo *p =3D pids[i];
> +      if (p->ctty =3D=3D ntty && p->pgid =3D=3D pgid && p->exec_dwProce=
ssId)
> +	return true;
> +    }
> +  return false;
> +}
> diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
> index e2e6dfeb6..e1de7ab46 100644
> --- a/winsup/cygwin/tty.h
> +++ b/winsup/cygwin/tty.h
> @@ -20,6 +20,7 @@ details. */
>  #define INPUT_AVAILABLE_EVENT	"cygtty.input.avail"
>  #define OUTPUT_MUTEX		"cygtty.output.mutex"
>  #define INPUT_MUTEX		"cygtty.input.mutex"
> +#define PCON_MUTEX		"cygtty.pcon.mutex"
>  #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
>  #define TTY_SLAVE_READING	"cygtty.slave_reading"
>
> @@ -72,7 +73,7 @@ public:
>    dev_t getntty () const {return ntty;}
>    _minor_t get_minor () const {return device::minor (ntty);}
>    pid_t getpgid () const {return pgid;}
> -  void setpgid (int pid) {pgid =3D pid;}
> +  void setpgid (int pid);
>    int getsid () const {return sid;}
>    void setsid (pid_t tsid) {sid =3D tsid;}
>    void kill_pgrp (int);
> @@ -89,6 +90,13 @@ class tty: public tty_min
>  public:
>    pid_t master_pid;	/* PID of tty master process */
>
> +  /* Transfer direction for fhandler_pty_slave::transfer_input() */
> +  enum xfer_dir
> +  {
> +    to_cyg,
> +    to_nat
> +  };
> +
>  private:
>    HANDLE _from_master;
>    HANDLE _from_master_cyg;
> @@ -98,6 +106,7 @@ private:
>    HANDLE _to_slave_cyg;
>    bool pcon_activated;
>    bool pcon_start;
> +  pid_t pcon_start_pid;
>    bool switch_to_pcon_in;
>    pid_t pcon_pid;
>    UINT term_code_page;
> @@ -114,6 +123,8 @@ private:
>    UINT previous_code_page;
>    UINT previous_output_code_page;
>    bool master_is_running_as_service;
> +  bool req_xfer_input;
> +  xfer_dir pcon_input_state;
>
>  public:
>    HANDLE from_master () const { return _from_master; }
> @@ -148,9 +159,12 @@ public:
>    static void __stdcall create_master (int);
>    static void __stdcall init_session ();
>    void wait_pcon_fwd (bool init =3D true);
> +  bool pcon_input_state_eq (xfer_dir x) { return pcon_input_state =3D=
=3D x; }
> +  bool pcon_fg (pid_t pgid);
>    friend class fhandler_pty_common;
>    friend class fhandler_pty_master;
>    friend class fhandler_pty_slave;
> +  friend class tty_min;
>  };
>
>  class tty_list
> --
> 2.30.0
>
>
