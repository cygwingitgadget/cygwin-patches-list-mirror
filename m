Return-Path: <cygwin-patches-return-2519-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3430 invoked by alias); 25 Jun 2002 22:15:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3412 invoked from network); 25 Jun 2002 22:15:32 -0000
Message-ID: <0be401c21c96$09d150e0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
Cc: <cygwin-patches@cygwin.com>
References: <20020622150321.13099.qmail@web20708.mail.yahoo.com> <04a101c219ff$81bedf80$6132bc3e@BABEL> <3D185911.CB269110@yahoo.com> <0b9801c21c8e$6a87be90$6132bc3e@BABEL> <3D18E43D.4606557D@yahoo.com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
Date: Tue, 25 Jun 2002 20:04:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00502.txt.bz2

"Earnie Boyd" <earnie_boyd@yahoo.com> wrote:
> You're welcome.  BTW, comments are forbidden in the w32api headers
> beyond what are already there.  This is due to the fact that most of
the
> headers are included when you include windows.h and a consensus was
> made to remove comments to help speed up reading the headers.
> Once GCC-3.2 is out and we have compilable headers that may change.

Oops. I even got the idea for the comment from another such
_WIN32_WINNT check further down in winbase.h.  Oh well, that's what I
get for trying to be clever :-)  I'll go snip out my comment.

Cheers,

// Conrad


