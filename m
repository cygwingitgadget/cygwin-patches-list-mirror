Return-Path: <cygwin-patches-return-4148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9736 invoked by alias); 31 Aug 2003 14:50:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9725 invoked from network); 31 Aug 2003 14:50:10 -0000
Message-ID: <3F520B0F.2050306@netscape.net>
Date: Sun, 31 Aug 2003 14:50:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <3F4F60A9.78B2260@phumblet.no-ip.org> <20030829155425.GA12672@redhat.com> <20030829160426.GA13083@redhat.com>
In-Reply-To: <20030829160426.GA13083@redhat.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q3/txt/msg00164.txt.bz2

cgf@redhat.com wrote:
> On Fri, Aug 29, 2003 at 11:54:25AM -0400, Christopher Faylor wrote:
> 
>>In any event, I have just found an interesting paper by Ulrich Drepper
> 
> 
> http://people.redhat.com/drepper/posix-signal-model.xml
> 

To supplement this, I'd also suggest having a look at the detailed 
comments and implementations in the the linux-2.6 kernel.  I think they 
help to put many of the concepts presented in both that document and the 
SUS into some perspective.

Slightly off-topic (I know), but I think these other papers by Uli also 
make for good reading (some of the concepts in Chapter 5 could be 
relevant to making Cygwin's threading more robust):
http://people.redhat.com/drepper/nptl-design.pdf
http://people.redhat.com/drepper/glibcthreads.html

Cheers,
Nicholas
