Return-Path: <cygwin-patches-return-2518-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20566 invoked by alias); 25 Jun 2002 21:46:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20531 invoked from network); 25 Jun 2002 21:46:45 -0000
Message-ID: <3D18E43D.4606557D@yahoo.com>
Date: Tue, 25 Jun 2002 15:15:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Accept-Language: en
MIME-Version: 1.0
To: Conrad Scott <Conrad.Scott@dsl.pipex.com>
CC: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
References: <20020622150321.13099.qmail@web20708.mail.yahoo.com> <04a101c219ff$81bedf80$6132bc3e@BABEL> <3D185911.CB269110@yahoo.com> <0b9801c21c8e$6a87be90$6132bc3e@BABEL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00501.txt.bz2

Conrad Scott wrote:
> 
> "Earnie Boyd" <earnie_boyd@yahoo.com> wrote:
> > Yes, you may commit the change except make the ChangeLog entry
> >
> >         * include/winbase.h (FILE_FLAG_FIRST_PIPE_INSTANCE): Add
> > constant.
> 
> Done.
> 
> Sorry that this took such an effort. I'll try to do a bit better next
> time.
> 
> Thanks for your time.
> 

You're welcome.  BTW, comments are forbidden in the w32api headers
beyond what are already there.  This is due to the fact that most of the
headers are included when you include windows.h and a consensus was made
to remove comments to help speed up reading the headers.  Once GCC-3.2
is out and we have compilable headers that may change.

Earnie.
