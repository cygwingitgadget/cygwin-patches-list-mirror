Return-Path: <cygwin-patches-return-1968-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5776 invoked by alias); 11 Mar 2002 12:25:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5735 invoked from network); 11 Mar 2002 12:25:38 -0000
Message-ID: <3C8CA1FC.2243D2ED@yahoo.com>
Date: Mon, 11 Mar 2002 07:02:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
CC: dannysmith@cygwin.com
Subject: [Fwd: src/winsup/w32api ChangeLog include/accctrl.h  ...]
Content-Type: multipart/mixed;
 boundary="------------9ED36A271B83A4E0BD57AE99"
X-SW-Source: 2002-q1/txt/msg00325.txt.bz2

This is a multi-part message in MIME format.
--------------9ED36A271B83A4E0BD57AE99
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 236

Danny,

This isn't a proper ChangeLog.  You need to list each file on a separate
line.  If the change to the file is the same as the previously listed
file then use `Ditto.' or `Likewise.'  Please correct the ChangeLog.

Thanks,
Earnie.
--------------9ED36A271B83A4E0BD57AE99
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 20902

X-Apparently-To: earnie_boyd@yahoo.com via web12104.mail.yahoo.com; 09 Mar 2002 01:04:21 -0800 (PST)
X-Track: 2: 40
Return-Path: <cygwin-cvs-return-2349-earnie_boyd=yahoo.com@cygwin.com>
Received: from sources.redhat.com (209.249.29.67)
  by mta454.mail.yahoo.com with SMTP; 09 Mar 2002 01:04:21 -0800 (PST)
Received: (qmail 4053 invoked by alias); 9 Mar 2002 09:04:16 -0000
Mailing-List: contact cygwin-cvs-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Unsubscribe: <mailto:cygwin-cvs-unsubscribe-earnie_boyd=yahoo.com@cygwin.com>
List-Subscribe: <mailto:cygwin-cvs-subscribe@cygwin.com>
List-Post: <mailto:cygwin-cvs@cygwin.com>
List-Help: <mailto:cygwin-cvs-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-cvs-owner@cygwin.com
Delivered-To: mailing list cygwin-cvs@cygwin.com
Received: (qmail 4026 invoked by uid 9302); 9 Mar 2002 09:04:12 -0000
Date: 9 Mar 2002 09:04:12 -0000
Message-ID: <20020309090412.4022.qmail@sources.redhat.com>
From: dannysmith@cygwin.com
To: cygwin-cvs@cygwin.com
Subject: src/winsup/w32api ChangeLog include/accctrl.h  ...
X-Mozilla-Status2: 00000000
Content-length: 19791

CVSROOT:	/cvs/src
Module name:	src
Changes by:	dannysmith@sources.redhat.com	2002-03-09 01:04:11

Modified files:
	winsup/w32api  : ChangeLog 
	winsup/w32api/include: accctrl.h aclapi.h basetsd.h basetyps.h 
	                       cderr.h cguid.h commctrl.h commdlg.h 
	                       cpl.h cplext.h custcntl.h dbt.h dde.h 
	                       ddeml.h dlgs.h excpt.h httpext.h 
	                       imagehlp.h imm.h initguid.h intshcut.h 
	                       ipexport.h iphlpapi.h ipifcons.h 
	                       iprtrmib.h iptypes.h isguids.h largeint.h 
	                       lm.h lmaccess.h lmalert.h lmapibuf.h 
	                       lmat.h lmaudit.h lmbrowsr.h lmchdev.h 
	                       lmconfig.h lmcons.h lmerr.h lmerrlog.h 
	                       lmmsg.h lmremutl.h lmrepl.h lmserver.h 
	                       lmshare.h lmsname.h lmstats.h lmsvc.h 
	                       lmuse.h lmuseflg.h lmwksta.h lzexpand.h 
	                       mapi.h mciavi.h mcx.h mmsystem.h 
	                       mswsock.h nb30.h nddeapi.h nspapi.h 
	                       ntdef.h ntsecapi.h ntsecpkg.h oaidl.h 
	                       objbase.h objfwd.h objidl.h odbcinst.h 
	                       ole.h ole2.h ole2ver.h oleauto.h olectl.h 
	                       olectlid.h oledlg.h oleidl.h pbt.h 
	                       prsht.h psapi.h rapi.h ras.h raserror.h 
	                       rassapi.h regstr.h richedit.h richole.h 
	                       rpc.h rpcdce.h rpcdce2.h rpcdcep.h 
	                       rpcndr.h rpcnsi.h rpcnsip.h rpcnterr.h 
	                       rpcproxy.h schannel.h schnlsp.h 
	                       scrnsave.h security.h setupapi.h 
	                       shellapi.h shlguid.h shlobj.h sql.h 
	                       sqlext.h sqltypes.h sqlucode.h sspi.h 
	                       subauth.h tlhelp32.h unknwn.h userenv.h 
	                       w32api.h winbase.h wincon.h wincrypt.h 
	                       windef.h windows.h windowsx.h winerror.h 
	                       wingdi.h wininet.h winioctl.h winnetwk.h 
	                       winnls.h winnt.h winperf.h winreg.h 
	                       winresrc.h winsock.h winsock2.h 
	                       winspool.h winsvc.h winuser.h winver.h 
	                       ws2tcpip.h wsnetbs.h wtypes.h zmouse.h 

Log message:
	* include/accctrl.h, aclapi.h, basetsd.h, basetyps.h, cderr.h,
	cguid.h, commctrl.h, commdlg.h, cpl.h, cplext.h, custcntl.h,
	dbt.h, dde.h, ddeml.h, dlgs.h, excpt.h, httpext.h, imagehlp.h,
	imm.h, initguid.h, intshcut.h, ipexport.h, iphlpapi.h,
	ipifcons.h, iprtrmib.h, iptypes.h, isguids.h, largeint.h, lm.h,
	lmaccess.h, lmalert.h, lmapibuf.h, lmat.h, lmaudit.h,
	lmbrowsr.h, lmchdev.h, lmconfig.h, lmcons.h, lmerr.h,
	lmerrlog.h, lmmsg.h, lmremutl.h, lmrepl.h, lmserver.h,
	lmshare.h, lmsname.h, lmstats.h, lmsvc.h, lmuse.h, lmuseflg.h,
	lmwksta.h, lzexpand.h, mapi.h, mciavi.h, mcx.h, mmsystem.h,
	mswsock.h, nb30.h, nddeapi.h, nspapi.h, ntdef.h, ntsecapi.h,
	ntsecpkg.h, oaidl.h, objbase.h, objfwd.h, objidl.h, odbcinst.h,
	ole.h, ole2.h, ole2ver.h, oleauto.h, olectl.h, olectlid.h,
	oledlg.h, oleidl.h, pbt.h, prsht.h, psapi.h, rapi.h, ras.h,
	raserror.h, rassapi.h, regstr.h, richedit.h, richole.h, rpc.h,
	rpcdce.h, rpcdce2.h, rpcdcep.h, rpcndr.h, rpcnsi.h, rpcnsip.h,
	rpcnterr.h, rpcproxy.h, schannel.h, schnlsp.h, scrnsave.h,
	security.h, setupapi.h, shellapi.h, shlguid.h, shlobj.h, sql.h,
	sqlext.h, sqltypes.h, sqlucode.h, sspi.h, subauth.h,
	tlhelp32.h, unknwn.h, userenv.h, w32api.h, winbase.h, wincon.h,
	wincrypt.h, windef.h, windows.h, windowsx.h, winerror.h,
	wingdi.h, wininet.h, winioctl.h, winnetwk.h, winnls.h, winnt.h,
	winperf.h, winreg.h, winresrc.h, winsock.h, winsock2.h,
	winspool.h, winsvc.h, winuser.h, winver.h, ws2tcpip.h,
	wsnetbs.h, wtypes.h, zmouse.h:	Add #pragma GCC system_header
	if __GNUC__ >= 3.
	* include/mapi.h: Change header guard name to _MAPI_H  for
	consistency.

Patches:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/ChangeLog.diff?cvsroot=src&r1=1.157&r2=1.158
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/accctrl.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/aclapi.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/basetsd.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/basetyps.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/cderr.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/cguid.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/commctrl.h.diff?cvsroot=src&r1=1.12&r2=1.13
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/commdlg.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/cpl.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/cplext.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/custcntl.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/dbt.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/dde.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ddeml.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/dlgs.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/excpt.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/httpext.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/imagehlp.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/imm.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/initguid.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/intshcut.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ipexport.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/iphlpapi.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ipifcons.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/iprtrmib.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/iptypes.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/isguids.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/largeint.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lm.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmaccess.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmalert.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmapibuf.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmat.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmaudit.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmbrowsr.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmchdev.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmconfig.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmcons.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmerr.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmerrlog.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmmsg.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmremutl.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmrepl.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmserver.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmshare.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmsname.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmstats.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmsvc.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmuse.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmuseflg.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lmwksta.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/lzexpand.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/mapi.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/mciavi.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/mcx.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/mmsystem.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/mswsock.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/nb30.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/nddeapi.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/nspapi.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ntdef.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ntsecapi.h.diff?cvsroot=src&r1=1.8&r2=1.9
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ntsecpkg.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/oaidl.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/objbase.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/objfwd.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/objidl.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/odbcinst.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ole.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ole2.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ole2ver.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/oleauto.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/olectl.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/olectlid.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/oledlg.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/oleidl.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/pbt.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/prsht.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/psapi.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rapi.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ras.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/raserror.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rassapi.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/regstr.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/richedit.h.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/richole.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpc.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcdce.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcdce2.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcdcep.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcndr.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcnsi.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcnsip.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcnterr.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/rpcproxy.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/schannel.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/schnlsp.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/scrnsave.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/security.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/setupapi.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/shellapi.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/shlguid.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/shlobj.h.diff?cvsroot=src&r1=1.12&r2=1.13
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/sql.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/sqlext.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/sqltypes.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/sqlucode.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/sspi.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/subauth.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/tlhelp32.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/unknwn.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/userenv.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/w32api.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winbase.h.diff?cvsroot=src&r1=1.19&r2=1.20
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wincon.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wincrypt.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/windef.h.diff?cvsroot=src&r1=1.8&r2=1.9
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/windows.h.diff?cvsroot=src&r1=1.8&r2=1.9
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/windowsx.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winerror.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wingdi.h.diff?cvsroot=src&r1=1.9&r2=1.10
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wininet.h.diff?cvsroot=src&r1=1.7&r2=1.8
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winioctl.h.diff?cvsroot=src&r1=1.4&r2=1.5
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winnetwk.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winnls.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winnt.h.diff?cvsroot=src&r1=1.45&r2=1.46
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winperf.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winreg.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winresrc.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winsock.h.diff?cvsroot=src&r1=1.9&r2=1.10
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winsock2.h.diff?cvsroot=src&r1=1.13&r2=1.14
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winspool.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winsvc.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winuser.h.diff?cvsroot=src&r1=1.17&r2=1.18
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/winver.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/ws2tcpip.h.diff?cvsroot=src&r1=1.2&r2=1.3
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wsnetbs.h.diff?cvsroot=src&r1=1.1&r2=1.2
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/wtypes.h.diff?cvsroot=src&r1=1.6&r2=1.7
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/w32api/include/zmouse.h.diff?cvsroot=src&r1=1.1.1.1&r2=1.2

--------------9ED36A271B83A4E0BD57AE99--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

