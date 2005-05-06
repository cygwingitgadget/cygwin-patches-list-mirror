Return-Path: <cygwin-patches-return-5434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3999 invoked by alias); 6 May 2005 22:29:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3653 invoked from network); 6 May 2005 22:29:01 -0000
Received: from unknown (HELO sccrmhc14.comcast.net) (204.127.202.59)
  by sourceware.org with SMTP; 6 May 2005 22:29:01 -0000
Received: from [192.168.0.100] (c-24-10-254-137.hsd1.ut.comcast.net[24.10.254.137])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005050622290001400e9lque>; Fri, 6 May 2005 22:29:00 +0000
Message-ID: <427BEFAC.8090502@byu.net>
Date: Fri, 06 May 2005 22:29:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00030.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Sigh. We need a bash maintainer.
> We need to have // working for mkdir -p to work, from what I
> understand of the code snippet that was sent to the list.

`mkdir -p' only uses chdir(), mkdir(), and stat() calls.  For
//server/share/newdir, the strace sequence would be (with Paul Eggert's
patch):

chdir("//") - success
mkdir("server") - fail (hopefully EEXIST, but don't give up yet)
stat("server") - success (and S_ISDIR better be true)
chdir("server") - success
mkdir("share") - fail (again, hopefully with EEXIST)
stat("share") - success (and S_ISDIR is true)
chdir("share") - success
mkdir("newdir") - success

It is the stat calls where the decision is made whether the mkdir failed
because the directory was already there vs. couldn't be created, done in
that order to avoid races.  I intend on releasing coreutils-5.3.0-6 as
soon as a snapshot has your minimal working //server as a directory, such
that the above strace works.

As to the accessibility of // and //server, your first cut should make
them mode 444 (dr--r--r--) for now.  That way, you do not have to support
readdir() (which only makes sense if you have search permssion), but you
do support pathname resolution, and forbid adding or deleting servers or
shares as though they were files.  If readdir() is added (and bash
patched, obviously), then change the accessibility to 555.

Also, what should //.. resolve to, / or //?  And if it resolves to /,
should // be an entry in the readdir() of /?  I would argue that //..
should resolve to //, meaning we just have two distinct roots in the
directory tree.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe++r84KuGfSFAYARAo7fAJ97YdifZyUBImxFNpTCOZ60UC+9wACgw76U
PSjw9LYS5eelqE1FdnKuU5Y=
=D774
-----END PGP SIGNATURE-----
