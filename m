Return-Path: <cygwin-patches-return-2368-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30596 invoked by alias); 8 Jun 2002 13:56:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30582 invoked from network); 8 Jun 2002 13:56:58 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Robert Collins'" <robert.collins@syncretize.net>,
	"'Robb, Sam'" <sam.robb@timesys.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: sem_getvalue patch
Date: Sat, 08 Jun 2002 06:56:00 -0000
Message-ID: <007301c20ef4$5b659bf0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <000801c20e42$8461fd80$0200a8c0@lifelesswks>
X-SW-Source: 2002-q2/txt/msg00351.txt.bz2

Ok, well I'll hold off for the assignment.

Rob

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Robert Collins
> Sent: Saturday, 8 June 2002 2:44 AM
> To: 'Robb, Sam'; cygwin-patches@cygwin.com
> Subject: RE: sem_getvalue patch
> 
> 
> Thanks, this looks good, I'll do a closer review in the weekend.
> 
> Rob
> 
> > -----Original Message-----
> > From: cygwin-patches-owner@cygwin.com 
> > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Robb, Sam
> > Sent: Saturday, 8 June 2002 2:35 AM
> > To: cygwin-patches@cygwin.com
> > Subject: RE: sem_getvalue patch
> > 
> > 
> > [original message was to cygwin@cygwin.com]
> > 
> > > With a little effort, I've managed to build a cygwin1.dll 
> > that exports
> > > sem_getvalue().  The version of cygwin1.dll that I built 
> > seems subtly
> > > hosed, though - while I can compile and run my test program from
> > > within a Windows cmd.exe shell, trying to run bash or ls 
> > (and probably
> > > a great many other things) hangs.
> > 
> > Here's the patch... fairly straightforward, if I've 
> understood the SUS
> > spec for the function correctly :-/
> > 
> > As for the apparent hangs in bash/ls/etc. - well, perhaps it was my
> > patch, perhaps not, as I was building from latest cvs source.  Since
> > I can't find any documentation that indicates if a particular method
> > for adding an export to cygiwn.din needs to be followed, this patch
> > simply tacks sem_getvalue to the end of the list.
> > 
> > Thanks,
> > 
> > -Samrobb
> > 
> > winsup/cygwin/ChangeLog entry:
> > 
> > 2002-06-06  Sam Robb <sam.robb@timesys.com>
> > 
> > 	* pthread.cc (sem_getvalue): New function.
> > 	* thread.cc (__sem_getvalue): Diito.
> > 	* thread.h (__sem_getvalue): Ditto.
> > 	* include/semaphore.h (sem_getvalue): Ditto.
> > 	* posix.sgml: Add sem_getvalue to "Synchronization" section.
> > 	* cygwin.din: Add symbol for sem_getvalue().
> > 
> > winsup/doc/ChangeLog entry:
> > 
> > 2002-06-06  Sam Robb <sam.robb@timesys.com>
> > 
> > 	* calls.texinfo: Remove 'unimplemented' tag from sem_getvalue.
> > 
> 
> 
