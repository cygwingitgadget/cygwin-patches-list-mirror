Return-Path: <cygwin-patches-return-4673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18614 invoked by alias); 12 Apr 2004 23:32:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18601 invoked from network); 12 Apr 2004 23:32:46 -0000
Message-Id: <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 12 Apr 2004 23:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Last path.cc
In-Reply-To: <20040411034553.GA6129@coe.bosbc.com>
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
 <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00025.txt.bz2

At 11:45 PM 4/10/2004 -0400, Christopher Faylor wrote:
>On Sat, Apr 10, 2004 at 11:37:07PM -0400, Pierre A. Humblet wrote:
>>This should take care of the issues I listed yesterday evening.
>>
>>I simply don't understand the logic in normalize_win32_path
>>well enough to touch it intelligently. 
>>So I removed the final . in the dumbest way possible
>
>Why do we have to remove the final dot?
>
>How does that jive with the goal of munging windows paths as little
>as possible.

Windows paths go through the symlink evaluation and path existence
loops as all others. Keeping the final /. causes abnormal behavior
with some symlinks (Cygwin looks for /..lnk).
Also the non-uniform normalization complicates other routines. For
example hash_path_name() contains special code to detect and remove
the final /. 

About the "normalized_path", I would still recommend replacing
get_name() by get_win32_name() in fchown32, fchmod, fstat64, facl32
and perhaps fhandler_disk_file::mmap. Otherwise making changes to the
mounts can cause calls on opened files to fail. It's also faster.

Once that is done, get_name() only remains useful in printf statements.
Its use in the virtual handlers and two other odd places can easily
be replaced by get_win32_name() (!!) too.

Pierre

