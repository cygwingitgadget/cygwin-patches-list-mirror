Return-Path: <cygwin-patches-return-2426-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9031 invoked by alias); 14 Jun 2002 04:04:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9016 invoked from network); 14 Jun 2002 04:04:11 -0000
Message-ID: <20020614040411.54096.qmail@web20003.mail.yahoo.com>
Date: Thu, 13 Jun 2002 21:04:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: passwd edited /etc/passwd patch
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20020613180714.N30892@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-902068227-1024027451=:51393"
X-SW-Source: 2002-q2/txt/msg00409.txt.bz2

--0-902068227-1024027451=:51393
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 970

--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> On Tue, Jun 11, 2002 at 08:18:15PM -0500, Joshua Daniel Franklin wrote:
> > +  /* Try getting a Win32 username in case the user edited /etc/passwd */
> > +  if (ret == NERR_UserNotFound)
> > +  {
> > +    if ((pw = getpwnam (user)))
> > +      cygwin_internal (CW_EXTRACT_DOMAIN_AND_USER, pw, domain, (char *)
> user);
> 
> Thanks for the patch but, hmm, I think I'd prefer to look always for
> the Cygwin username first.
> It's unlikely and probably just an academic case but you could have
> the Cygwin username user_a for the windows user user_b and vice versa.
> 

Umm...kay. I was trying to avoid the extra system call, but I guess it
probably won't make much difference. I'm having build problems right now 
but I think this patch will do what you're asking. 


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
--0-902068227-1024027451=:51393
Content-Type: application/octet-stream; name="passwd.c-patch"
Content-Transfer-Encoding: base64
Content-Description: passwd.c-patch
Content-Disposition: attachment; filename="passwd.c-patch"
Content-length: 1143

LS0tIHBhc3N3ZC5jLW9yaWcJVHVlIEp1biAxMSAyMDoxMzo1MSAyMDAyCisr
KyBwYXNzd2QuYwlUaHUgSnVuIDEzIDIyOjU5OjU5IDIwMDIKQEAgLTE2LDYg
KzE2LDcgQEAgZGV0YWlscy4gKi8KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNp
bmNsdWRlIDxnZXRvcHQuaD4KICNpbmNsdWRlIDxwd2QuaD4KKyNpbmNsdWRl
IDxzeXMvY3lnd2luLmg+CiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5j
bHVkZSA8dGltZS5oPgogCkBAIC0xMDcsNyArMTA4LDE0IEBAIEdldFBXIChj
b25zdCBjaGFyICp1c2VyKQogICBXQ0hBUiBuYW1lWzUxMl07CiAgIERXT1JE
IHJldDsKICAgUFVTRVJfSU5GT18zIHVpOwotCisgIHN0cnVjdCBwYXNzd2Qg
KnB3OworICBjaGFyICpkb21haW4gPSAoY2hhciAqKSBtYWxsb2MgKE1BWF9Q
QVRIICsgMSk7CisgICAgIAorICAvKiBUcnkgZ2V0dGluZyBhIFdpbjMyIHVz
ZXJuYW1lIGluIGNhc2UgdGhlIHVzZXIgZWRpdGVkIC9ldGMvcGFzc3dkICov
CisgIGlmICgocHcgPSBnZXRwd25hbSAodXNlcikpKQorICAgIHJldCA9IGN5
Z3dpbl9pbnRlcm5hbCAoQ1dfRVhUUkFDVF9ET01BSU5fQU5EX1VTRVIsIHB3
LCBkb21haW4sIChjaGFyICopIHVzZXIpOworICBpZiAocmV0ID09IChpbnQp
IE5VTEwpCisgICAgcHJpbnRmICgiV2luZG93cyB1c2VybmFtZSA6ICVzXG4i
LCB1c2VyKTsKICAgTXVsdGlCeXRlVG9XaWRlQ2hhciAoQ1BfQUNQLCAwLCB1
c2VyLCAtMSwgbmFtZSwgNTEyKTsKICAgcmV0ID0gTmV0VXNlckdldEluZm8g
KE5VTEwsIG5hbWUsIDMsIChMUEJZVEUgKikgJnVpKTsKICAgcmV0dXJuIEV2
YWxSZXQgKHJldCwgdXNlcikgPyBOVUxMIDogdWk7Cg==

--0-902068227-1024027451=:51393--
