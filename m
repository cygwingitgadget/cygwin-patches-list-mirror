Return-Path: <cygwin-patches-return-3433-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16192 invoked by alias); 21 Jan 2003 15:51:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16156 invoked from network); 21 Jan 2003 15:51:44 -0000
Message-ID: <3E2D6CF9.FF47B7F4@ieee.org>
Date: Tue, 21 Jan 2003 15:51:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00082.txt.bz2

Christopher Faylor wrote:
> 
> After consolidating all of the lock code into a "refresh" method,
> I realized that there are some pretty big races in the group/passwd
> code.  You can't just protect the reading of the buffers against
> multiple access, you have to protect all operations which manipulate
> the passwd/group buffers since they could be changed out from under
> you otherwise.

That's absolutely right. The current logic protects only against 
concurrent writes (which are very unlikely due to the 
WaitForSingleObject), but not against conflicts between writers
and readers. That was discussed before. The lock must be set
before calling isinitializing. It can either be a simple lock, 
or a sophisticated one writer/many readers. 
Now there is a new twist: interaction between the passwd and the
group accesses.

This has been there forever, I would not delay the release of 1.3.19

By the way, I wrote the internal_get{pw,gr} routines having in mind
that they could be extended to handle those multiple access issues,
avoiding to have to set and release locks in routines outside of
passwd.cc and group.cc (with a few exceptions).
 
Pierre
