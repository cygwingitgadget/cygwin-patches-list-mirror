Return-Path: <cygwin-patches-return-2067-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21545 invoked by alias); 16 Apr 2002 14:54:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21495 invoked from network); 16 Apr 2002 14:54:45 -0000
Date: Tue, 16 Apr 2002 07:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
Message-ID: <20020416145454.GB32707@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de> <20020415150129.GA6372@redhat.com> <3CBAF313.1438CF6C@ieee.org> <20020415154209.GG6372@redhat.com> <3CBAFDA5.444F884E@ieee.org> <20020416090632.E6120@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020416090632.E6120@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00051.txt.bz2

On Tue, Apr 16, 2002 at 09:06:32AM +0200, Corinna Vinschen wrote:
>On Mon, Apr 15, 2002 at 12:19:49PM -0400, Pierre A. Humblet wrote:
>> Christopher Faylor wrote:
>> 
>> > How can you second that 100% and then talk about how people have to
>> > change ther code to accomodate cygwin?  
>> I second 100% that it's best to find a solution that avoids the MS 
>> bug without requiring any change from Unix.
>> Meanwhile nobody "has to" do anything as a result of including
>> my proposal. 
>> I hope this discussion will generate better approaches.
>
>I think there's only one approach which would allow applications
>to run without special Cygwin patches.  When duplicating a socket,
>Cygwin needs to know the parent-child relationship between the
>sockets.  When closing a socket, the DLL has to check, if there's
>still a child socket left open.  If so, the socket isn't closed
>but moved into a "still-to-close" queue (like the delqueue) until
>all child sockets are closed.  The same for the application itself.
>If exit() has been called, Cygwin has to keep the application in a
>zombie-like state until the child sockets have been closed.
>
>The problem is that this requires a parent-child communication
>which isn't implemented yet.  This would be a job for the Cygwin
>daemon.
>
>Does that invalidate Pierre's approach?  I don't think so.

I don't see why a daemon is needed.  There is already parent/child
communication going on without the daemon.

cgf
