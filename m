Return-Path: <cygwin-patches-return-4682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17920 invoked by alias); 13 Apr 2004 14:47:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17910 invoked from network); 13 Apr 2004 14:47:05 -0000
Message-ID: <407BFD67.74005F2F@phumblet.no-ip.org>
Date: Tue, 13 Apr 2004 14:47:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net> <20040413124306.GD26558@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00034.txt.bz2



Corinna Vinschen wrote:
> 
> On Apr 12 19:29, Pierre A. Humblet wrote:
> > At 11:45 PM 4/10/2004 -0400, Christopher Faylor wrote:
> > >On Sat, Apr 10, 2004 at 11:37:07PM -0400, Pierre A. Humblet wrote:
> > >>This should take care of the issues I listed yesterday evening.
> > >>
> > >>I simply don't understand the logic in normalize_win32_path
> > >>well enough to touch it intelligently.
> > >>So I removed the final . in the dumbest way possible
> > >
> > >Why do we have to remove the final dot?
> > >
> > >How does that jive with the goal of munging windows paths as little
> > >as possible.
> >
> > Windows paths go through the symlink evaluation and path existence
> > loops as all others. Keeping the final /. causes abnormal behavior
> > with some symlinks (Cygwin looks for /..lnk).
> > Also the non-uniform normalization complicates other routines. For
> > example hash_path_name() contains special code to detect and remove
> > the final /.
> >
> > About the "normalized_path", I would still recommend replacing
> > get_name() by get_win32_name() in fchown32, fchmod, fstat64, facl32
>                                                       ???????
> 
> > and perhaps fhandler_disk_file::mmap. Otherwise making changes to the
> > mounts can cause calls on opened files to fail. It's also faster.
> 
> I think the better approach is to change all these functions to
> work on handles instead of filenames.  

I agree 100% with that. But in cases where it's not possible 
(fhandler_disk_file::mmap), and on 9X, it makes more sense
to use the win32_name, which is closer to hardware.
We already use it in the inode hash for the same reason.

About the reference to fstat64, I got carried away. 
Instead of recomputing the hash there, it would be better to call
get_namehash, the hash is always set in fhandler_base::set_name.
But doing that is also wasteful, it's not used when inodes are
available. Lazy evaluation seems indicated here:
get_namehash () { namehash? namehash : namehash = hash_path_name (0, pc.get_win32_name ())

Pierre
