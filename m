Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id 836F13858D35
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 11:12:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 836F13858D35
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1639134767;
 bh=5zqdpU7AbQ6DEh5mYpTgEhJLya6HK6oQmWwa/oXlK8g=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=b+MNxMpy2WfPDZnl1KzhD6fcGsAxv3wwO7GZgdP3q25FDcRQDj+7f4Pzw1Sx4P3/v
 iMwGWvwTjRXYQ97cTloM9uvkN/eh095FWddcMnzw+Gb4iwVjGvl5j4LkqmogJpGExo
 OwDr+hkJ+EqbOUNON8dj9ezwU+yych2bjCJ2U9mo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1nDJEs47oe-00Hhmi; Fri, 10
 Dec 2021 12:12:47 +0100
Date: Fri, 10 Dec 2021 12:12:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
In-Reply-To: <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2112101152320.90@tvgsbejvaqbjf.bet>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
 <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/ENPrHf6+A2Ao/2YXTc6nJ2FwGDi9dnp9jk53fpuT7+DZrSc4sO
 BCOHjgXfTbltFhMS1jF3MS2o01fNlnHY+y8KeIbUzn7zx8IlDW4CZNGpnv+pYFydJcziCiB
 jN4AWHRnDEFqo7oRLsI4uv2qXmrwN8+1wRJC1KDoD4hOttYHOgjGjFLal/GC3Dch06yTdRe
 s4f3IHP5xElkrZ9Sd5+yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1cvoB8BIyy0=:2u1LNRWeE55JcXqgHkJUuR
 5PrImy9rI9Zpo9Xs/zbKQed3vhyEW1vJTfZidgEZbCINSpp7wu7WkKwHD5W6Q0W03Etj3lumY
 ARJVVRthw07qY7+CgnnWhSaQcuJpW0uznY0cb4hD2zAvBFJDbNgigp9WZEy8oPhGlJlKUH/Ag
 XDvLvfJeX878ArPRdgYPTJcmucKonUtLScKeoiu/2bztgS6L+15wXzsTrrRNuGSKlkuwjEVLZ
 eBjpb8VbJauznPZkBvoFg9ZTscqE1DC8Y11R/LKtPKP7GSilmIZjjINXD1nrPK6vu5JoOq0Pi
 yzAAGKcG2Fj/YOhidoYqsTUKekLsbSbNPkbsagCDeA+CUjQmafAmSkkYNZagPAwVZl1/bSJx4
 3i1wNWqRkaMRCdaBWOxNe2QzKlKF0lE+w9AXBoHJFxxOWv7ccPzYMT2Aa8i4IMAiu74iLDu0q
 jWduTyBGvtlEcQ5Ml569cggNR73JYLDpEE0K0pcy52DS9p/Gg2PGc3RgDl+thmvSdsP4vaiJY
 wUsZK4svb8X9k/j9sypwkHPdFALDjoJqCiRJ4PIKrIFIJPgSlMJranLOhIKEdJ4Wge+J8ujx5
 xkDqEFBHZN78uN+IvJNgeIHZ4kWlvR/OV4oKk1g9KDMlrV2K2qxNFsyB7Gyc83ob2revGQH95
 I40ik4qNrD+j3me0uosoFMc06Dm7nNSNCXwKR43sYCwoc7LtN9SPkZwoFTtocIWrAQ1+loMn8
 PLtU/BgHMPbrP3hZRDqGj/mrA+i1zk0utRJ8uKBrpDSHBduIOI3PVYOQHXIJl2Qd2tT+qxhPc
 IfMf8uXYMlF6l6XZ9IpLiFfHWP0EpHVrXMc/nAnNCzcF8QyK9oo9vG9uVDJaLIsc3m4XndGo9
 3OjmmZLIJZms6qYBdliJ4sjHoQtdd6sx04clok4hjvJke2aUu12hxExNKycjzFxA9vKVKspcO
 hFiqivSUpN+jYgNPNBM9u074wk8g0Oe90+WyWM2kXzN9O7aAbEMklfME5/jhziwqvojAejh91
 rFAKFpsSUfxvgecs0GbH6JuRv2i30wMch0+K54dKQ63DNQduGULws0VJNxLEoUhIXygP73I/A
 5nZT06faK8gjL0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 10 Dec 2021 11:12:56 -0000

Hi Takashi,

On Fri, 10 Dec 2021, Takashi Yano wrote:

> On Fri, 10 Dec 2021 00:05:27 +0100 (CET)
> Johannes Schindelin wrote:
> > sorry for responding to a patch you sent almost 10 months ago... but..=
. I
> > am struggling with it.
> >
> > First of all, let me describe the problem I am seeing (see also
> > https://github.com/git-for-windows/git/issues/3579): after upgrading t=
he
> > MSYS2 runtime to v3.3.3 in Git for Windows, whenever I ask `git.exe` t=
o
> > spawn `vim.exe` to edit any file, after quitting `vim` I see spurious =
ANSI
> > sequences being "ghost-typed" into the terminal (which is a MinTTY run=
ning
> > under `TERM=3Dxterm`).
> >
> > Apparently the ANSI sequences report the cursor position and the
> > foreground/background color in response to a CSI [ 6n sent from `vim`.
> >
> > Clearly, those sequences should go to `vim.exe`, but they mostly don't
> > arrive there (but in MinTTY instead, as if I had typed them). Sometime=
s,
> > the foreground/background color seems to arrive in the `vim` process, =
but
> > the cursor position almost always does not. I suspect that it is impor=
tant
> > that `git.exe` is a non-MSYS2 process whereas `vim.exe` is an MSYS2
> > process, and something inside the MSYS2 runtime is at fault.
> >
> > I've bisected this incorrect behavior to the patch I am replying to.
> >
> > I tried to trigger the same bug in pure Cygwin (as opposed to MSYS2),
> > specifically using `disable_pcon` (because MSYS2 defaults to not using=
 the
> > pseudo console support because I ran into too many issues to be confid=
ent
> > enough in it yet), but I think that Cygwin's `vim` is too old and
> > therefore might not even send that CSI [ 6n (although `:h t_RV` _does_
> > show the expected help).
> >
> > Now, the patch which I am responding to is completely obscure to me. I=
t is
> > very, very unclear to me whether it really tries to only do one thing
> > (namely to transfer the input no longer in `read()` but in `setpgid()`=
),
> > or rather does many things at once. Even worse, I have not the faintes=
t
> > clue how this patch is trying to accomplish what the commit message
> > describes (_because_ it does so many things at once), nor how that cou=
ld
> > be related to the observed incorrect behavior, and as a consequence I =
have
> > no idea how I can hope to fix said observed incorrect behavior.
> >
> > Could you help shed some light into the problem?
>
> Thanks for the report.
> Could you please test if the following patch solves the issue?

It does!

However, I am a bit frustrated because there is still a lot light-shedding
to be done. In the current shape of the code, I do not even understand
what it does, let alone why it works around the problem.

For example, why is there such a long `pcon` stuff going on? I am in the
_disabled_ pseudo console mode, for starters. Like, why is there a
`pcon_input_state`? And why has the `disable_pcon` code path changed at
all (there was no need to touch it, was there)?

Also, `needs_xfer` clearly means `needs transfer`. What transfer? What's
`masked`? And how does it differ from `mask`?

I fear that the pseudo console/non-pseudo console code currently has a
lottery factor of 1. I spent a good part of three entire working days
pouring over it, and I still do not understand it. Usually, a combination
of reading the commit messages, reading the code, parsing
function/variable names with a sprinkling of intuition gets me very far in
understanding any kind of legacy code, but not here. And I do _a lot_ of
legacy code hacking, as part of maintaining Git for Windows. The pseudo
console code in Cygwin really is a class of its own in this regard.

And I have the very strong sense that it does not have to be that way.

I would really like it if the code in `fhandler_*` could see some tender,
loving care, bringing clarity about, for example clearly distinguishing
between the code paths that use pseudo console support vs not, and code
paths regarding Cygwin processes vs not.

I mean, even if your diff below is short, I cannot review it. Not the
context, not my study of three days of the surrounding code and the commit
messages, none of that equips me with enough knowledge to even spot an
obvious bug, because such a bug would still not be obvious to me.

I really hope that this can be fixed. Please let me know if there is
anything I can do to help bring this about.

Thank you,
Johannes

>
>
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.=
cc
> index f523dafed..ba282b897 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1239,10 +1239,13 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool=
 mask, bool xfer)
>    else if (InterlockedDecrement (&num_reader) =3D=3D 0)
>      CloseHandle (slave_reading);
>
> +  bool need_xfer =3D
> +    get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
> +
>    /* In GDB, transfer input based on setpgid() does not work because
>       GDB may not set terminal process group properly. Therefore,
>       transfer input here if isHybrid is set. */
> -  if (isHybrid && !!masked !=3D mask && xfer
> +  if ((isHybrid || need_xfer) && !!masked !=3D mask && xfer
>        && GetStdHandle (STD_INPUT_HANDLE) =3D=3D get_handle ())
>      {
>        if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
> @@ -1536,7 +1539,7 @@ out:
>    if (ptr0)
>      { /* Not tcflush() */
>        bool saw_eol =3D totalread > 0 && strchr ("\r\n", ptr0[totalread =
-1]);
> -      mask_switch_to_pcon_in (false, saw_eol);
> +      mask_switch_to_pcon_in (false, saw_eol || len =3D=3D 0);
>      }
>  }
>
> @@ -2214,6 +2217,15 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>        return len;
>      }
>
> +  if (to_be_read_from_pcon () && !get_ttyp ()->pcon_activated
> +      && get_ttyp ()->pcon_input_state =3D=3D tty::to_cyg)
> +    {
> +      WaitForSingleObject (input_mutex, INFINITE);
> +      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> +					  get_ttyp (), input_available_event);
> +      ReleaseMutex (input_mutex);
> +    }
> +
>    line_edit_status status =3D line_edit (p, len, ti, &ret);
>    if (status > line_edit_signalled && status !=3D line_edit_pipe_full)
>      ret =3D -1;
>
> --
> Takashi Yano <takashi.yano@nifty.ne.jp>
>
