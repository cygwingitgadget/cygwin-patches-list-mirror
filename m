From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Cc: <cygwin-apps@cygwin.com>
Subject: baby steps vs overhaul
Date: Sun, 30 Sep 2001 16:45:00 -0000
Message-id: <00e301c14a0a$3090f820$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00251.html

I've cross posted this, because it should really be on -developers, but
I'm not sure if Ronald is there. Certainly -apps is a better place
than -patches - and anyone can subscribe to -apps.

I've got my fingers in a few open source projects - mainly Squid and
Cygwin though. I watch closely the lists for a handfull of others.

I've seen two main approaches to changing the architecture of an open
source project. I'm going to call them the overhaul and baby steps
approaches.

The Overhaul approach.
In this approach a new CVS branch is created for the new code. Develop
progress's at a rapid pace. Things are broken, and fixed again.
Occasionally a bug is found that is relevant to the HEAD branch an
backported. When the original sponsors of the work get it to a usable
(in terms of stability and feature completeness) point, _they will often
start using it_. That is nearly a kiss of death. Why? because the
motiviation to get it acceptable to the gatekeepers of the HEAD branch
is gone. Also, the HEAD branch has proceeded at its own pace, and
incompatible changes have occured. Disruption _will_ occur when they try
to merge the two. It can eventually happen, but it can be quite
disruptive. See for example libtool and the MLB branch. The merge was
_way_ over due when it happened. OTOH Apache 2.0 seems to have managed
this approach successfully. However they set a deliberate target for the
overhaul, so the whole project knew what was happening.

My 2c here: When doing a overhaul, 3 things are needed:
1) Complete backing from the project 'team'.
2) A commitment from the project team to work with the folk doing the
overhaul to prevent introducing new features that conflict with the
overhauled code. At a minimum those who want to introduce the feature
have to do it on both branches.
3) A clear (and realistic) release point for the bait-and-switch (when
the overhauled code is merged onto the HEAD) to occur.

The baby steps approach.
In this approach a new CVS branch is created for the new code. At every
opportunity the usuable subsection of the code base is merged into HEAD.
Depending on the release approach for the project 'opportunity' can have
different meanings. Typically a merge would occur immediately after a
stable release went out the door, and not merges would occur in the
freeze leading up to a new stable release. All changes to HEAD are
incorporated into the branch, so it only contains a bare minimum of
differences. At some points, architectural changes that affect 40% or
50% of the codebase may have to be incorporated. These are handled no
differently. They are pulled into HEAD in the smallest chunks that can
be made. They may not be optimal, or ideal when they go into HEAD, but
they will
a) work
b) not be (substantially) worse than what was there.
c) any new features will be off-by-default.
In this approach, there is never any significant reason to use the
development branch for any length of time, because the features are
rolled into HEAD at speed.

My 2x here: When doing a baby steps architectural change, 2 things are
needed:
1) Complete backing from the project 'team'.
2) Willingness from the project developers to live with the occasional
hiccup that *will* occur when extracting a minimal change from the
development branch - the tradeoff being that if any feature in HEAD is
broken the change is (relatively) small and isolated.


Those paying attention may notice that the baby steps jives very well
with the release-early release-often approach. In fact both methods
allow this, the difference being that the overhaul will do parallel
releases and the baby steps will do regular merges to HEAD. Also these
are simply the extreme cases, things can be done in the middle.

I've overhauled the authentication system in Squid, from a
non-orthogonal incrementally grown item, to a modular system allowing
multiple authentication schemes with differing semantics, and including
today NTLM and Digest authentication. This was accomplished via a
baby-steps approach. The initial work was merged in when all the core
architectural changes had occured (kindof a mini-overhaul), but _way_
before everything was stable. And things have changed substantially
since then. All the development work is done on a branch, and changes
merged in when they are stable.

As for cygwin and this file system handler/file handler overhaul. (Which
Ronald, I do agree should be the target)....

I _suggest_ (Hey, I'm not the one coding here :]) something like the
following:
A set of mini-targets none of which will destabilise cygwin, and the sum
of which achieves the goal. Yes, a baby steps approach.
Here's a _possible_ list.
1) Add a file system handler base class. Add a win32 fshandler
derivative class.
-- a release could occur
2) Add the capability to manipulate the mount table with associated
fshandlers. (this involves altering mount.exe as well.)
3) Alter setup to understand the updated mount table.
-- a release could occur
4,4a,4b,...) One function at a time alter the existing
fhandler-centric-code to use the fshandler concept to obtain the correct
fhandler to use.
-- a release could occur between any of the 4x steps
5) Create a (pick one: devfs or registryfs) fshandler.
-- a release could occur
6) Move the current stat to the win32 fshandler.
-- a release could occur
7) Implement stat () in devfs.
-- a release could occur
8) Move opendir and readdir to the win32 fshandler.
-- a release could occur
9) Implement opendir and readdir in devfs.
-- a release could occur
10) Alter the readdir wrapper to override returned entries with
mountpoint information.
-- a release could occur
11) Alter setup to add /dev as a mount point for devfs.
-- complete.

Perhaps I'm labouring the point? This will IMO get the architectural
overhaul complete, without ever hurting the current cygwin. There will
be points where the *new* code is not feature complete. I.e. at point 6)
calling stat() on /dev/clipboard WHEN devfs is mount at /dev will fail.
Who cares? Only someone who has gone to the deliberate effort of
mounting devfs at /dev will ever take that code path - and that means
it's a developer.

You will note that the changes to stat() and the like are the _last
things_ to happen. Thats because they work now, and cannot work
'correctly' until the architecture is changed.

I'm not authoritative for cygwin - this is only _my_ opinion. (Hey I
didn't say I don't have an ego though :}).

Rob
