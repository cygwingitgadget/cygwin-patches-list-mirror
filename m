Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 9A36A389680F
 for <cygwin-patches@cygwin.com>; Thu,  4 Feb 2021 19:29:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9A36A389680F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCsLo-1lGa1J0WRM-008vWx for <cygwin-patches@cygwin.com>; Thu, 04 Feb 2021
 20:29:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 720F3A806FB; Thu,  4 Feb 2021 20:29:20 +0100 (CET)
Date: Thu, 4 Feb 2021 20:29:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/8] syscalls.cc: Implement non-path_conv dependent
 _unlink_nt
Message-ID: <20210204192920.GK4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-5-ben@wijen.net>
 <20210126113441.GK4393@calimero.vinschen.de>
 <9868efcd-3e70-fcbf-ba60-33ad9a5a6f3c@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9868efcd-3e70-fcbf-ba60-33ad9a5a6f3c@wijen.net>
X-Provags-ID: V03:K1:NOICqBqHhV4VFgezYQBWPs8djTvt+ZzIf93vuur5PuG5X83JXq9
 qUwgAa58e7SJ1qH34tGl9RtZHBM1f1688c/P6Tk4ggYfEzTytmP8TdN0Vdi9MoCerRtzP1U
 2UM+Ad51BuObWJsrqZ87iC1/9lBoUxYCKpt/pFoLeZEAjlS427ThQMQ/PAfaBS6Bzm/y4F1
 64eihhf76dqIL4ofEOO5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XlcbZZ+tyKs=:JKiDzgbUD5btybKBtK/jOD
 fev/u3KM2azb7hhIrklRuSc73pIAnrte+1WWPusycT9FW6t4NBYeuwiB86yVPPDJenCEXFIEU
 dmp0iknjN4v9R996uZ23f+h8WxEEBu6f7+/zZG4x0gx0W84y4LebtjAbmWAjCWk4Ro2+Fjny2
 wQHq+QaKGjuBq33T74ZUfrh082onsxJlIP3C+4BhUUcQ1IQ/oSAOg1DV/tDi1O6KRHQtHkxxs
 hpeisDsY1knQkbSKdFXSE6jeV28ZPjgLvwD+UQsn1qAJa/C7yYeE7GyRP7qoFtuubvB8gUrst
 zqQzqOIsFQ1UFDwDiITnVL18OVqE0yETBhRLxppOSnlO2tTf62bi9SYG1oQYw7ZwVtptrfpfV
 2VJP+P0W/Z2FDYg3QEaRO6UcQ2RFUgK6zx4eleebRKJ/J9m+mcHCbqF8WdQL+rwfuiALJnJRK
 4fAjPjCEYQ==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 04 Feb 2021 19:29:24 -0000

On Feb  3 12:03, Ben wrote:
> On 26-01-2021 12:34, Corinna Vinschen via Cygwin-patches wrote:
> >> +  static bool has_posix_unlink_semantics =
> >> +      wincap.has_posix_unlink_semantics ();
> >> +  static bool has_posix_unlink_semantics_with_ignore_readonly =
> >> +      wincap.has_posix_unlink_semantics_with_ignore_readonly ();
> > 
> > Did you mean `const' rather than `static', by any chance?  Either way, I
> > don't think these local vars are required, given that the wincap
> > accessors are already marked as const.  The compiler should know how to
> > opimize this sufficiently.
> > 
> I do mean static.
> With each instantiation these are initialized to the wincap value.
> Then later on, we might disable the behavior if we encounter a driver
> which returns: STATUS_INVALID_PARAMETER
> 
> Assuming most files will reside on the same fs, (ie through the same driver)
> this will save use from the system call which we know isn't supported.

But this is an invalid assumption.  In fact, it only hold true for
`rm -r' scenarios, not for anything else.  What about long running
processes unlinking files in various spots under /var, /tmp, etc.,
i. .e. services.  Or what about mc?

Keep in mind that unlink/rmdir are system calls.  Each an every call is
independent of each other.  If you encounter two unlink calls, you don't
even know how much time has gone by between them.  Even if they occur in
a short time frame, you still don't know if they are even remotely
related.  For all you know, they could be called from different threads,
doing different things on different partitions.

As such, using a static state at this point and keeping it around for
later calls is a bug.

> >> +  ULONG flags = FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT
> >> +      | FILE_DELETE_ON_CLOSE | eflags;
> > 
> > This looks like a dangerous assumption.  So far we don't open unknown
> > reparse points as reparse points deliberately.  No one knows what a
> > unknown reparse point is good for or supposed to do, so we don't even
> > know if we are allowed to handle it analogue to a symlink.
> > 
> When opening these, you are correct.
> However, when a request is made to delete a reparse point, it's safe
> - even for an unknown reparse point - to assume that it is the reparse point
> itself which is to be deleted. Ofcourse: That's my theory.

It's definitely a deviation from the previous behaviour and I'm not
exactly comfortable with it.  The problem is that only a minor part of
the reparse point population is actually something akin to a symlink.  I
don't see how it can be a safe bet to allow the user to remove an RP
with unknown and, perhaps, crucial functionality to some given product.

> > Consequentially we open unknown reparse points just as normal files, so
> > that the reparse point's automatisms may kick in.  By omitting this
> > step, we're moving on thin ice.
> > 
> This would mean an unknown reparse point can never be deleted.
> I'm just not sure if that's what we should want.

It's what we do right now.  We're trying to handle all RP types known to
constitute some kind of symlink, and if we learn about the meaning of as
yet unknown RPs, and it *is* some kind of symlink, we can add it to the
list.

> >> +    {
> >> +      //Step 2
> >> +      //Reopen with all sharing flags, will set delete flag ourselves.
> >> +      access |= FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES;
> >> +      flags &= ~FILE_DELETE_ON_CLOSE;
> >> +      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_VALID_FLAGS, flags);
> >> +      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
> >> +
> >> +      if (NT_SUCCESS (fstatus))
> >> +        {
> >> +          if (has_posix_unlink_semantics_with_ignore_readonly)
> >> +            {
> >> +              //Step 3
> >> +              //Remove the file with POSIX unlink semantics, ignore readonly flags.
> > 
> > No check for NTFS?  Posix semantics are not supported on any other FS.
> > No check for remote?  Just because you support POSIX semantics on
> > *this* machine, doesn't mean the remote machine supports it at all...
> > 
> Indeed no checks.
> If the driver correctly returns STATUS_INVALID_PARAMETER we will not try again (by
> resetting the has_posix_unlink_semantics_with_ignore_readonly flag and then fallback to
> usual trickery. If the driver returns error (but not STATUS_INVALID_PARAMETER) that
> driver pays a single kernel call, which I deem acceptable.

That's back to the static var then, which isn't feasible.  For non-NTFS
or remote FSes you will introduce a constant penalty.

> >> +                          //As we don't have posix unlink semantics, this will still fail if the file is in use.
> > 
> > Without transaction?
> > 
> Well, yes, the transaction overhead doesn't weigh up to the unlikeliness of failure, I think.

The transaction would only be called for DOS R/O files anyway, which is
a minor part of the file population with a pretty high probability.  By
checking the R/O flag, the transaction is only called in those few
cases.

However, my POV on NTFS transactions got quite a dent after MSFT
deprecated them, and even more so after the transaction fiasko in the
rename2 function (see the NT_TRANSACTIONAL_ERROR case there, oh my).

Having said that, we may drop transactions in the non-POSIX-semantics
unlink case, but given the usually minor number of affected files, I
don't quite see the point.

> Because even if the delete fails, the attributes are restored. Or, very-unlikely-worst-case-scenario:
> Both fail and we're left with a file with FILE_ATTRIBUTE_ARCHIVE which means the file has been marked for deletion.

I don't get that.  What has the FILE_ATTRIBUTE_ARCHIVE bit to do with a
file marked for deletion?

> The general idea is to forgo path_conv's filesystem checks and just try to delete the file,
> if it fails, remember and fallback. After these series of commits, some will follow
> to try and see if we can remove/incorporate the fallback scenario completely.

I'm still far from being convinced this is a good idea.  Please keep in
mind that unlinking originally worked very differently.  I created the
unlink_nt function for the exact same reason you're trying to replace it
today: I was trying to shortcut as much as possible so unlinking (or
better: the bordercase called `rm -r') gets a lot faster.

unlink_nt also was quite a bit different from where it is now.  It was
a lengthy and painful process to hack on all problems which showed up
over time.

Shortcutting path_conv *will* result in unhandled or wrongly handled
cases.

What would *really* help: Speeding up path_conv, and maybe correct its
path handling along the way, i. e., handle the path from left to right
per POSIX instead of from right to left.  The latter was also a
shortcut, which still lives on, unfortunately.


Corinna
