Return-Path: <cygwin-patches-return-3429-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15366 invoked by alias); 21 Jan 2003 05:12:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15281 invoked from network); 21 Jan 2003 05:12:07 -0000
Date: Tue, 21 Jan 2003 05:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group
Message-ID: <20030121051325.GA4667@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00078.txt.bz2

On Mon, Jan 20, 2003 at 09:51:31PM -0500, Pierre A. Humblet wrote:
>Mostly good news recently:
>
>1) Chris' 51 line ChangeLog on 01-19 is his personal best since Sept 2000.
>When combined with the 31 line ChangeLog on 01-16, they exceed by
>far his record for the millennium (67 lines in Sept 2000).
>This is in a thread that has "Hmm.  I have a slightly less 
>intrusive idea for how to handle this.  I'll check it in shortly."
>Sorry Chris, I can't stop chuckling. It relieves the frustration
>you mentioned, but no hard feelings.

To quote from my followup email: "I only took a glance at what you'd
done and thought it could be done a little more simply.  As it turns
out, I was wrong,..."

Also, implying that there is a one-to-one correspondence between my
ChangeLog entries and the ones for your patches is a little simplistic.
However, if getting your shot in makes you feel better, then so be it.

>- "change_possible" is back to boolean instead of ternary values.

Yep.  Good catch.

>- arrays are back to size MAX_ETC_FILES

No.  Sorry.

>- no duplicated calls to test_file_change on Novell

Yep.  Should have caught this.

>- other useless etc::file_changed and etc::init calls avoided. 

Sorry, no.  I want to keep the input argument to etc::init.

>3) For future reference, the way the modified code works
>can be explained relatively simply, to the point where
>I feel I could write a formal proof.
>a) Initially the pwdgrp::state is "uninitialized". This causes
>  all internal and external get{pw,gr}XX functions to call 
>  read_etc_{passwd,group} and thus pwdgrp::load(filename).

If you are going to be modifying the isunintialized thing
then why didn't you go all the way and get rid of the repeated
code at the beginning of all of these functions?  Surely there
is some way not to have to:

  if (pr.isuninitialized () || (check && pr.isinitializing ()))
    read_etc_passwd ();

To invoke further hilarity, I may just pull read_etc_passwd into the
pwdgrp class and replace this with something like a 'pr.refresh()' or
something.  Be warned, though, it could result in a long ChangeLog.
Then you'll have *three* opportunities to talk about how I said
something could be done more simply.

>b) When pwdgrp::load is called in the uninitialized state, it
>  calls etc::init, which allocates an "ix handle", records a 
>  pointer to the w32 path, and calls etc::file_changed, thus
>  indirectly etc::dir_changed (with "change_possible" initialized
>  to false). If the /etc handle is NULL, FindFirstFileNotification
>  is called and the "change_possible" array is set to true.
>  If the handle is not NULL, change_possible is already true.
>  The current filetime is recorded and the "change_possible"
>  entry of the file itself is set to false.
>  load() then loads the file and changes the state to "loaded".
>c) Subsequent calls to get{pw,gr}XX invoke pwdgrp::isinitializing,
>  which calls etc::file_changed if the state is "loaded".
>  etc::file_changed first calls etc::dir_changed, which returns
>  true if change_possible is true or if /etc is on Novell or if 
>  /etc has changed. In this last case the array change_possible is
>  set to true to force time stamp checks on all files.
>  If dir_changed returns true, the file time is checked and file_changed
>  returns true, always resetting change_possible for the file to false.
>  If file_changed returns true, isinitializing () changes the state 
>  to "initializing" (insuring that it returns the same value 
>  when called several times in a row, e.g. due to mutex checks).
>  read_etc_yy and pwdgrp::load are called, loading the file and 
>  setting the state to "loaded" (without calling etc::init).
>  Possible changes in the w32 path are recorded by load and will 
>  be taken into account in future calls to etc::file_changed. 
>d) Following a fork in the loaded state, the first call (in the child)
>  to dir_changed (from 3) with false change_possible will detect that 
>  the NO_COPY /etc handle has been reset to NULL. As in (2) it calls 
>  FindFirstFileNotification and sets the change_possible array to true, 
>  which will eventually trigger a check of the timestamps.
>  
>  Note that: 
>  -any change to /etc/ or a fork will trigger a timestamp check. 
>  -a timestamp check is only performed: a) Initially (to set the time)
>   b) Following a change to /etc c) After a fork  d) On Novell.

This description is appreciated.  I don't think I am going to be making
your changes as is, however.

>4) To finish off the work and leave the code in a newly minted state, I 
>suggest the following cleanup (mostly deletions):
>- class pwdgrp
>     Delete operator = 

Yes.

>- pwdgrp::load 
>     Delete "fh = NULL"

Yes.

>and use a common CloseHandle, instead of duplicating it.

No.  The intent was to close the handle as quickly as possible.

>     Instead of having type bool just to produce an "it failed" message,
>     use type void and put a debug_printf on lines that have "res = false".

That's just a matter of preference.  However, I may do that in the future.
At that point, maybe you can say something about how I said it was a matter
of preference and chuckle about how I did it anyway.

>- etc::file_changed
>     Remove the test (!fn[n]) because a) it is never true (pc will always
>     return a pointer to its path)

I added this check as what we in the industry like to call "a defensive
measure" in case the file_changed was called prior to initialization.  This
was while the code was in flux and I was less clear on the flow than I
am now.  I agree that it can now be deleted.  I've deleted it a couple of
times and put it back in the course of the last week.

>and b) even if it was true, NULL is legal in FindFirstFile.

Well that's a pretty strange reason for keeping it, given your other
arguments.  When would NULL ever be a valid argument for something which
is obstensively checking for files in /etc?

Regardless, searching for the string NULL in the FindFirstFile definition
on MSDN I don't find any evidence of NULL being an allowable first
argument.

>     If you insist on keeping it, move the test to init().

Oh, I'm not insisting.  I'll remove it.

>- etc::test_file_changed
>     Consider reverting the code back to etc::file_changed. It is only 
>     called from that very short function.  

I like the shortness.  I think I'll keep it even though it is only
called from one place.  For modularity.

>- etc::change_possible
>     For modularity move "change_possible[n] = 0;" from file_changed
>     to dir_changed.  

The intent of having the setting in file_changed is to indicate that
change is no longer possible after the file has been tested.

>     Move definition of "change_possible" from etc class to a static 
>     in dir_changed, exactly as changed_h already is.

I think I'll leave it for now.

>     Alternatively put the handle and the string "/etc" in the etc class,
>     to make it applicable to any directory.

An obvious suggestion if there was ever going to be a need for this in
some other directory.
      
>- etc::last_modified
>     Remove from etc class and declare static inside test_file_changed,
>     see change_possible above.

See above.

>2003/01/20  Pierre Humblet  <pierre.humblet@ieee.org>
 2003-01-20


>	* pwdgrp.h (pwdgrp::isinitializing): Do not change the state when
>	it is uninitialized.
>	* uinfo.cc (pwdfrp::load): Only call etc::init when the state is
>	uninitialized.
>	* path.h: (class etc): Revert the type of change_possible to bool
                ^
             no colon here

Thanks.
cgf
