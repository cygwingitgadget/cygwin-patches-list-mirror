Return-Path: <cygwin-patches-return-2168-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16126 invoked by alias); 9 May 2002 19:43:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16085 invoked from network); 9 May 2002 19:43:56 -0000
Date: Thu, 09 May 2002 12:43:00 -0000
From: Christopher Faylor <cgf-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Cc: davidf87@hotmail.com
Subject: Re: Fwd: write(2) return codes
Message-ID: <20020509194411.GU6910@redhat.com>
Reply-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com,
	davidf87@hotmail.com
References: <F261Lvl1UmBT3kYzqCZ0000d916@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F261Lvl1UmBT3kYzqCZ0000d916@hotmail.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00152.txt.bz2

On Thu, May 09, 2002 at 12:28:57PM -0700, david f wrote:
>Now maybe this will get some attention on the second attempt.  I posted
>this last week with no response.
>
>The read and write system calls return the incorrect error code in some
>cases.  Details for write are below.  I have attached a patch that
>should address this problem, but since the build of cygwin 1.3.10 is so
>broken I have not been able to test it.

Yeah, right.  It's impossible to build 1.3.10.  I wonder how we managed
to even build it for a release.  That's rather astonishing.

>In answer to my previous question, there is a POSIX validation service
>which
>
>might help catch more problems like this: the Federal Information
>Processing
>
>Standard 151-2.  It is available at
>http://www.opengroup.org/testing/fips/ and seems to cover a lot more
>test cases than the ltp included with cygwin.

Yep.  A scan of the mailing list archives might unearth the fact that
others have run these tests in the past.  I used to do it a few years
ago to check signal compatibility but I doubt if anyone has done this
for some time.

>I ran most of the tests and there were many failures, but as I do not
>have NTFS, anything that uses permissions is an invalid result.  If
>anyone is interested in running this, I may be willing to help, but I
>won't pursue this problem any more until the read/write bug is fixed.

Your patch just blindly sets EBADF when the windows error is
ERROR_ACCESS_DENIED.  I am not convinced that this is a correct
solution.

cgf

>>From: "david f" <davidf87@hotmail.com>
>>To: cygwin@cygwin.com
>>CC: davidf87@hotmail.com
>>Subject: write(2) return codes
>>Date: Wed, 01 May 2002 13:17:01 -0700
>>
>>I've been doing some work on porting gnome to run on cygwin. One problem 
>>which I recently discovered in testing bonobo is that the write(2) system 
>>call seems to return the EACCES in the case where it should return EBADF. 
>>Here is a piece of code which demonstrates it:
>>
>>#include <unistd.h>
>>#include <stdio.h>
>>#include <fcntl.h>
>>#include <errno.h>
>>main () {
>>int fd = open("/tmp/test1", O_RDONLY);
>>int ret = write(fd, "foo", 3);
>>fprintf(stderr,"%d\n", errno);
>>}
>>
>>And the strace output from it
>>
>>  98  342468 [main] a 4016 _open: 3 = open (/tmp/test1, 0x0)
>> 125  342593 [main] a 4016 _write: write (3, 0x40104F, 3)
>> 104  342697 [main] a 4016 fhandler_base::write: binary write
>> 119  342816 [main] a 4016 seterrno_from_win_error: 
>>/cygnus/netrel/src/cygwin-1.3.10-1/winsup/cygwin/fhandler.cc:279 errno 5
>> 102  342918 [main] a 4016 geterrno_from_win_error: windows error 5 == 
>>errno 13
>>  95  343013 [main] a 4016 fhandler_base::write: -1 = write (0x40104F, 3)
>>  95  343108 [main] a 4016 _write: -1 = write (3, 0x40104F, 3)
>>
>>Note that windows returns error code 5, access denied, which is mapped on 
>>to EACCES. Bonobo expects either EBADF (which solaris returns in this case) 
>>
>>or EINVAL.
>>
>>Perhaps the single global error map is not the right approach. It is 
>>clearly not the correct behavior to always map windows ERROR_ACCESS_DENIED 
>>on to either EACCES or EBADF.
>>
>>I'm not a cygwin hacker, but I'll make a patch if there is some consensus 
>>on how to fix this. There also used to be tools for testing POSIX 
>>compliance that might catch some other cases of this, but I don't have any 
>>info on that at the moment.
>>
>>Please CC me on any mail, as I'm not on the mailing list.
>>
>>
>>Thanks,
>>
>>
>>David F
>>
>>>From: Steven O'Brien To: "david f" <davidf87@hotmail.com>
>>>Subject: Re: bonobo and gal patches
>>>Date: Wed, 1 May 2002 19:24:08 +0100
>>>
>>>Hi David
>>>I've had a look at SUSv2 which is the first reference point for cygwin,
>>>and definitely in that specification write() *never* sets errno EACCESS.
>>>I think EBADF, as used by solaris, is the correct errno according to
>>>SUSv2. You may want to raise this on the cygwin mailing listl certainly
>>>if you submit a patch there is a reasonable chance of it being accepted,
>>>given cygwin's aim of susv2 compliance whereever sensible and practical.
>>>A quick google search of the cygwin site for EACCESS does not show up
>>>anything. In the meantime I would put a #ifdef __CYGWIN__ conditional in
>>>the bonobo source to get the desired behaviour.
>>>
>>>Steven
>>>
>>>On Wed, 01 May 2002 10:52:22 -0700
>>>"david f" <davidf87@hotmail.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> Thanks for the patches. I haven't tested the gal patches yet, but the
>>>> bonobo patch is definitely an improvement over my first attempt.
>>>>
>>>> I have investigated the cause of the failure of the 1st test in
>>>> bonobo, and I now have a partial answer. The fragment of the test that
>>>> fails is a write to a file opened read-only. Bonobo expects this to
>>>> return EBADF or EINVAL, but cygwin returns EACCES. I've attached a
>>>> piece of strace output from a simple test case I wrote. Note the
>>>> geterrno_from_win_error returns error code 5, which is
>>>> "5L    ERROR_ACCESS_DENIED                   Access is denied."
>>>> according to MS. This is mapped on to EACCES.
>>>>
>>>> This is annoying, but it is not clear to me whether this should be
>>>> fixed in cygwin or bonobo. Ideally, cygwin should return EBADF or
>>>> EINVAL depending on whatever POSIX says (solaris seems to return
>>>> EBADF), but maybe windows should return ERROR_INVALID_HANDLE instead
>>>> of ERROR_ACCESS_DENIED. If we fix this in bonobo, we'll probably run
>>>> into this again. Maybe cygwin shouldn't map error codes from windows
>>>> to unix on global basis, and provide function-specific mappings for
>>>> greater compatibility.
>>>>
>>>> If you have any insight here let me know. I have only just realized
>>>> this problem, and perhaps there has already been some discussion of
>>>> this problem on cygwin mailing lists.
>>>>
>>>> Dave
>>>>
>>>> >From: Steven O'Brien <steven.obrien2@ntlworld.com>
>>>> >To: davidf87@hotmail.com
>>>> >Subject: bonobo and gal patches
>>>> >Date: Sat, 27 Apr 2002 13:55:16 +0100
>>>> >
>>>> >David
>>>> >Here are the 2 patches I promised you. As I said, bonobo test1 is
>>>> >failing with a permission denied exception, and I have only tried
>>>> >"make check", not run any other test program.
>>>> >Gal does not perform so well in its tests, but it should give you a
>>>> >start. Steven
>>>> ><< bonobo-1.0.20-cygwin.patch >>
>>>> ><< gal-0.19.1-cygwin.patch >>
>>>>
>>>>
>>>> _________________________________________________________________
>>>> Get your FREE download of MSN Explorer at
>>>> http://explorer.msn.com/intl.asp.
>>>>
>>
>
>
>_________________________________________________________________
>Send and receive Hotmail on your mobile device: http://mobile.msn.com

>diff -ur cygwin-1.3.10-1.orig/winsup/cygwin/fhandler.cc 
>cygwin-1.3.10-1/winsup/cygwin/fhandler.cc
>--- cygwin-1.3.10-1.orig/winsup/cygwin/fhandler.cc	Tue Feb 19 19:25:00 2002
>+++ cygwin-1.3.10-1/winsup/cygwin/fhandler.cc	Wed May  8 17:08:54 2002
>@@ -241,6 +241,11 @@
>	  /* This is really EOF.  */
>	  bytes_read = 0;
>	  break;
>+        case ERROR_ACCESS_DENIED:
>+          /* Windows returns this when reading from a file opened O_WRONLY,
>+             but POSIX expects EBADF. */
>+          set_errno(EBADF);
>+          return -1;
>	case ERROR_MORE_DATA:
>	  /* `bytes_read' is supposedly valid.  */
>	  break;
>@@ -614,6 +619,11 @@
>		  __seterrno ();
>		  if (get_errno () == EPIPE)
>		    raise (SIGPIPE);
>+                  /* Windows returns E_ACCESS_DENIED when writing to a file
>+                     opened with O_RDONLY, but POSIX expects EBADF. */
>+		  if (get_errno () == EACCES) {
>+                    set_errno(EBADF);
>+                  }
>		  /* This might fail, but it's the best we can hope for */
>		  SetFilePointer (get_handle (), current_position, 0, FILE_BEGIN);
>		  return -1;
>
>

>--
>Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
>Bug reporting:         http://cygwin.com/bugs.html
>Documentation:         http://cygwin.com/docs.html
>FAQ:                   http://cygwin.com/faq/
