From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-apps@cygwin.com
Subject: Re: baby steps vs overhaul
Date: Sun, 30 Sep 2001 17:19:00 -0000
Message-id: <20010930202016.B3722@redhat.com>
References: <00e301c14a0a$3090f820$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00252.html

On Mon, Oct 01, 2001 at 09:46:55AM +1000, Robert Collins wrote:
>The baby steps approach.
>In this approach a new CVS branch is created for the new code. At every
>opportunity the usuable subsection of the code base is merged into HEAD.
>Depending on the release approach for the project 'opportunity' can have
>different meanings. Typically a merge would occur immediately after a
>stable release went out the door, and not merges would occur in the
>freeze leading up to a new stable release. All changes to HEAD are
>incorporated into the branch, so it only contains a bare minimum of
>differences. At some points, architectural changes that affect 40% or
>50% of the codebase may have to be incorporated. These are handled no
>differently. They are pulled into HEAD in the smallest chunks that can
>be made. They may not be optimal, or ideal when they go into HEAD, but
>they will
>a) work
>b) not be (substantially) worse than what was there.
>c) any new features will be off-by-default.
>In this approach, there is never any significant reason to use the
>development branch for any length of time, because the features are
>rolled into HEAD at speed.

I'll chime in here again to note that this is the only plan that I
will accept at this point.

The basic problem is one of trust.  If the work was being contemplated
by someone who had already worked on cygwin's file handler code and
who had a proven track record, I'd be somewhat willing to go with major
overhauls.

In this case, it is not clear to me that anyone who is contemplating
doing the work has actually even looked at the code.  Ronald doesn't
even yet know how to *debug cygwin*.  So, how could I possibly consider
allowing someone who lacks such fundamental knowledge to completely
redesign the core of my project?

It's easy to speculate about the way that things should be.  AFAICT, we
haven't even completely recapitulated the last discussion that we had on
this subject.  But, then, I haven't been paying close attention.

The proof, as always, will be in the execution.

>My 2x here: When doing a baby steps architectural change, 2 things are
>needed:
>1) Complete backing from the project 'team'.
>2) Willingness from the project developers to live with the occasional
>hiccup that *will* occur when extracting a minimal change from the
>development branch - the tradeoff being that if any feature in HEAD is
>broken the change is (relatively) small and isolated.

All that is required is for someone to submit a patch for consideration.
I certainly will consider a patch that advances an architectural goal but
I'm not going to accept something that breaks cygwin for any length of time.

I'd like to also be convinced that anyone submitting patches is going to
be around for the long haul.  I accepted, much against my better judgement,
patches from people who were going to add pthreads to cygwin and make it
thread safe.  As we all know, the patches were incomplete and the people
disappeared.  I'm not going to repeat that mistake again

>2) Add the capability to manipulate the mount table with associated
>fshandlers. (this involves altering mount.exe as well.)

I don't know why this would involve mount.  Except for one specific case
for the cygdrive stuff, mount just calls setmntent/getmntent/endmntent
to display information.  If we have to do something different from that
then, IMO, the model is wrong.

However, your points are well taken.  Thank you for enumerating the ways
that an incremental approach to this design could be taken.

I want to also point out the fact that Cygwin is a product that is used
and sold by Red Hat.  We can't afford (literally) to keep it in an unstable
state for too long.

Can I suggest that this discussion should move to cygwin-developers?  Since
there are no patches involved here, it is not appropriate for cygwin-patches.
It is not discussing the cygwin net release, so it is not appropriate for
cygwin-apps, either.

cgf
