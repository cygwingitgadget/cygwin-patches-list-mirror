Return-Path: <cygwin-patches-return-2996-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24261 invoked by alias); 18 Sep 2002 01:41:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24247 invoked from network); 18 Sep 2002 01:41:01 -0000
Message-Id: <3.0.5.32.20020917213708.00810580@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Tue, 17 Sep 2002 18:41:00 -0000
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
 <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: RE: open () on Win95 directories
In-Reply-To: <NCBBIHCHBLCMLBLOBONKOEEMDFAA.g.r.vansickle@worldnet.att.ne
 t>
References: <3.0.5.32.20020917205836.0080c100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00444.txt.bz2

At 08:18 PM 9/17/2002 -0500, Gary R. Van Sickle wrote:
>Hehehehe, I was just about to hit send on a reply to your original email
on this
>Pierre!  It wasn't going to have a nice patch attached though.  Thanks for
>tracking this down and fixing it.

This problem is fixed, but there is another one! Solving the other one
would best
be done with the help of the mutt developer and integrated in the main release
(same for the fopen( ,"b"), by the way, he shouldn't object).

The problem is that hard links are not implemented on FAT, and dotlock.c
relies
on the hardlink count. You will see that it will timeout.
However there is NO NEED to look at the hardlink count when the link succeeds
(only when it fails, which can happen because of NFS problems even though the
actual link succeeded on the remote machine), because when it succeeds the
count 
MUST be 2.
This is how exim does it, not because of Win95 but for efficiency sake. 
Below I cut and pasted a relevant part of appendfile.c that explains the
logic.

By the way, exim uses both fcntl and dotlock by default (can be changed from
exim.conf), so mutt could interoperate with exim with fcntl only.

Pierre
  

****************************************************************************
*****
  if (ob->use_lockfile)
    {
    lockname = string_sprintf("%s.lock", filename);
    hitchname = string_sprintf( "%s.%s.%08x.%08x", lockname, primary_hostname,
      (unsigned int)(time(NULL)), (unsigned int)getpid());

    DEBUG(D_transport) debug_printf("lock name: %s\nhitch name: %s\n",
lockname,
      hitchname);

    /* Lock file creation retry loop */

    for (i = 0; i < ob->lock_retries; sleep(ob->lock_interval), i++)
      {
      int rc;
      hd = Uopen(hitchname, O_WRONLY | O_CREAT | O_EXCL, ob->lockfile_mode);

      if (hd < 0)
        {
        addr->basic_errno = errno;
        addr->message =
          string_sprintf("creating lock file hitching post %s "
            "(euid=%ld egid=%ld)", hitchname, (long int)geteuid(),
            (long int)getegid());
        return FALSE;
        }

      /* Attempt to hitch the hitching post to the lock file. If link()
      succeeds (the common case, we hope) all is well. Otherwise, fstat the
      file, and get rid of the hitching post. If the number of links was 2,
      the link was created, despite the failure of link(). If the hitch was
      not successful, try again, having unlinked the lock file if it is too
      old.

      There's a version of Linux (2.0.27) which doesn't update its local cache
      of the inode after link() by default - which many think is a bug - but
      if the link succeeds, this code will be OK. It just won't work in the
      case when link() fails after having actually created the link. The Linux
      NFS person is fixing this; a temporary patch is available if anyone is
      sufficiently worried. */

      if ((rc = Ulink(hitchname, lockname)) != 0) fstat(hd, &statbuf);
      close(hd);
      Uunlink(hitchname);
      if (rc != 0 && statbuf.st_nlink != 2)
        {
        if (ob->lockfile_timeout > 0 && Ustat(lockname, &statbuf) == 0 &&
            time(NULL) - statbuf.st_ctime > ob->lockfile_timeout)
          {
          DEBUG(D_transport) debug_printf("unlinking timed-out lock file\n");
          Uunlink(lockname);
          }
        DEBUG(D_transport) debug_printf("link of hitching post failed -
retrying\n");
        continue;
        }

      DEBUG(D_transport) debug_printf("lock file created\n");
      break;
      }

    /* Check for too many tries at creating the lock file */

    if (i >= ob->lock_retries)
      {
      addr->basic_errno = ERRNO_LOCKFAILED;
      addr->message = string_sprintf("failed to lock mailbox %s (lock file)",
        filename);
      return FALSE;
      }
    }

