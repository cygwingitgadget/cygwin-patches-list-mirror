Return-Path: <cygwin-patches-return-3613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3185 invoked by alias); 21 Feb 2003 16:11:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3171 invoked from network); 21 Feb 2003 16:11:09 -0000
Message-ID: <3E565022.4E01CCCA@ieee.org>
Date: Fri, 21 Feb 2003 16:11:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: access()
References: <3.0.5.32.20030220201534.007fb310@mail.attbi.com> <20030221143127.GL1403@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00262.txt.bz2

Corinna Vinschen wrote:

> Applied.

Corinna,

I am still worried about using !real_path.exists() to determine
non existence, as done in several places in Cygwin. 
That function checks if the file attributes are FFFFFFFF

After some experiments I found out that GetFileAttributes returns
FFFFFFF on an existing file if
a) the file ACL does not allow the caller to read the attributes
and
b) the directory is unreadable.
Do you agree or is it more complicated?

In principle this does not prevent the caller from reading the
security descriptor.

To return more accurate information, symlink_info::check could call
GetLastError. If it == 5, the file exists but there is an access problem. 
What to do then is TBD.

If we take for granted that (with the existing code) the situation is
hopeless when the file attributes are FFFFFFFFF then the test 
  if (!pc->exists ())
    {
      debug_printf ("already determined that pc does not exist");
could be moved from fhandler_disk_file::fstat_by_name
to fhandler_disk_file::fstat (after the get_io_handle test).

While we are at it, set_query_open (query_open_already = true);
could also be called when a file has acls and ntsec is true.

On the other hand, if we keep the fstat code as it is, then for consistency
the following code in access
  if (!real_path.exists ())
    {
      set_errno (ENOENT);
      return -1;
    }

  if (!(flags & (R_OK | W_OK | X_OK)))
    return 0;

should be weakened to
  if (real_path.exists () && !(flags & (R_OK | W_OK | X_OK)))
    return 0
so that we go ahead and try to read the sd even with !real_path.exists()

What you you think?

Pierre
