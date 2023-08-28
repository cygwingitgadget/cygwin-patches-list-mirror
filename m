Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0013.nifty.com (mta-snd00014.nifty.com [106.153.226.46])
	by sourceware.org (Postfix) with ESMTPS id 6322A3858D28
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 11:53:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6322A3858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0013.nifty.com with ESMTP
          id <20230828115349294.MXUK.104052.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 20:53:49 +0900
Date: Mon, 28 Aug 2023 20:53:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: termios: Refactor the function
 is_console_app().
Message-Id: <20230828205349.5e88f193446048e42337685b@nifty.ne.jp>
In-Reply-To: <ZOx911vVsEZOgfgI@calimero.vinschen.de>
References: <20230828092129.770-1-takashi.yano@nifty.ne.jp>
	<ZOx911vVsEZOgfgI@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Aug 2023 12:58:31 +0200
Corinna Vinschen wrote:
> On Aug 28 18:21, Takashi Yano wrote:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/termios.cc | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index 789ae0179..d106955dc 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -704,22 +704,20 @@ static bool
> >  is_console_app (const WCHAR *filename)
> >  {
> >    HANDLE h;
> > -  const int id_offset = 92;
> >    h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> >  		   NULL, OPEN_EXISTING, 0, NULL);
> >    char buf[1024];
> >    DWORD n;
> >    ReadFile (h, buf, sizeof (buf), &n, 0);
> >    CloseHandle (h);
> > -  char *p = (char *) memmem (buf, n, "PE\0\0", 4);
> > -  if (p && p + id_offset < buf + n)
> > -    return p[id_offset] == '\003'; /* 02: GUI, 03: console */
> > -  else
> > -    {
> > -      wchar_t *e = wcsrchr (filename, L'.');
> > -      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> > -	return true;
> > -    }
> > +  /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
> > +     IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
> > +  IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
> 
> Please use PIMAGE_NT_HEADERS instead and just drop the comment.
> We don't support 32 bit anyway.

This function is used for determining whether a non-cygwin
app is console app or not. Even in 64-bit cygwin, 32-bit
non-cygwin app can be executed. So we should support both
32-bit and 64-bit binary.

However, using IMAGE_NT_HEADERS may be better. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
