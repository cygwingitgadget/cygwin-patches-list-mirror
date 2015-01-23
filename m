Return-Path: <cygwin-patches-return-8051-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29414 invoked by alias); 23 Jan 2015 02:06:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28495 invoked by uid 89); 23 Jan 2015 02:05:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=2.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_MANY_HDRS_LCASE,URIBL_DBL_ABUSE_BOTCC autolearn=no version=3.3.2
X-HELO: vms173013pub.verizon.net
Received: from vms173013pub.verizon.net (HELO vms173013pub.verizon.net) (206.46.173.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 23 Jan 2015 02:05:57 +0000
Received: from pool-108-7-11-152.bstnma.east.verizon.net ([108.7.11.152]) by vms173013.mailsrvcs.net (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014)) with ESMTPSA id <0NIL00E82XTPH2L1@vms173013.mailsrvcs.net> for cygwin-patches@cygwin.com; Thu, 22 Jan 2015 20:05:50 -0600 (CST)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=LrklEcZZ c=1 sm=1 tr=0	a=qu2GBZ4KwuZJuA9HnZzXhA==:117 a=4RoUMAPcAAAA:8 a=o1OHuDzbAAAA:8	a=oR5dmqMzAAAA:8 a=YNv0rlydsVwA:10 a=WYyz33bNM761EKJ0Nl0A:9	a=Qu-28JpdWi2fAAOS:21 a=IHbg6bnDHB0d1RM1:21 a=CjuIK1q_8ugA:10	a=lMyJj8CBKKTWEJ1IZQcA:9
Message-id: <0NIL00E86XTQH2L1@vms173013.mailsrvcs.net>
Date: Fri, 23 Jan 2015 02:06:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: [PATCH] Add-on to gethostbyname2
MIME-version: 1.0
Content-type: multipart/mixed; boundary="=====================_84710711==_"
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00006.txt.bz2


--=====================_84710711==_
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-length: 5031

Add-on to gethostbyname2, as discussed previously on main list.
The diff is also attached.


Pierre

2015-01-22  Pierre A. Humblet <pierre@phumblet.no-ip.org>

         * net.cc (cygwin_inet_pton): Declare.
         (gethostby_specials): New function.
         (gethostby_helper): Change returned addrtype in 4-to-6 case.
         (gethostbyname2): Call gethostby_specials.



cvs diff -up net.cc
Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.322
diff -u -p -r1.322 net.cc
--- net.cc      20 Jan 2015 18:23:19 -0000      1.322
+++ net.cc      23 Jan 2015 00:02:22 -0000
@@ -72,6 +72,7 @@ extern "C"
    int __stdcall rcmd (char **ahost, unsigned short inport, char *locuser,
                       char *remuser, char *cmd, SOCKET * fd2p);
    int sscanf (const char *, const char *, ...);
+  int cygwin_inet_pton(int, const char *, void *);
    int cygwin_inet_aton(const char *, struct in_addr *);
    const char *cygwin_inet_ntop (int, const void *, char *, socklen_t);
    int dn_length1(const unsigned char *, const unsigned char *,
@@ -1168,6 +1169,97 @@ memcpy4to6 (char *dst, const u_char *src
    memcpy (dst + 12, src, NS_INADDRSZ);
  }

+/* gethostby_specials: RFC 6761
+   Handles numerical addresses and special names for gethostbyname2 */
+static hostent *
+gethostby_specials (const char *name, const int af,
+                   const int addrsize_in, const int addrsize_out)
+{
+  int namelen = strlen (name);
+  /* Ignore a final '.' */
+  if ((namelen == 0) || ((namelen -= (name[namelen - 1] == '.')) == 0))  {
+    set_errno (EINVAL);
+    h_errno = NETDB_INTERNAL;
+    return NULL;
+  }
+
+  int res;
+  u_char address[NS_IN6ADDRSZ];
+  /* Test for numerical addresses */
+  res = cygwin_inet_pton(af, name, address);
+  /* Test for special domain names */
+  if (res != 1) {
+    {
+      char const match[] = "invalid";
+      int const matchlen = sizeof(match) - 1;
+      int start = namelen - matchlen;
+      if ((start >= 0) && ((start == 0) || (name[start-1] == '.'))
+         && (strncasecmp (&name[start], match , matchlen) == 0)) {
+       h_errno = HOST_NOT_FOUND;
+       return NULL;
+      }
+    }
+    {
+      char const match[] = "localhost";
+      int const matchlen = sizeof(match) - 1;
+      int start = namelen - matchlen;
+      if ((start >= 0) && ((start == 0) || (name[start-1] == '.'))
+         && (strncasecmp (&name[start], match , matchlen) == 0)) {
+       res = 1;
+       if (af == AF_INET) {
+         address[0] = 127;
+         address[1] = address[2] = 0;
+         address[3] = 1;
+       }
+       else {
+         memset (address, 0, NS_IN6ADDRSZ);
+         address[NS_IN6ADDRSZ-1] = 1;
+       }
+      }
+    }
+  }
+  if (res != 1)
+    return NULL;
+
+  int const alias_count = 0, address_count = 1;
+  char * string_ptr;
+  int sz = DWORD_round (sizeof(hostent))
+    + sizeof (char *) * (alias_count + address_count + 2)
+    + namelen + 1
+    + address_count * addrsize_out;
+  hostent *ret = realloc_ent (sz,  (hostent *) NULL);
+  if (!ret)
+    {
+      /* errno is already set */
+      h_errno = NETDB_INTERNAL;
+      return NULL;
+    }
+
+  ret->h_addrtype = af;
+  ret->h_length = addrsize_out;
+  ret->h_aliases = (char **) (((char *) ret) + DWORD_round (sizeof(hostent)));
+  ret->h_addr_list = ret->h_aliases + alias_count + 1;
+  string_ptr = (char *) (ret->h_addr_list + address_count + 1);
+  ret->h_name = string_ptr;
+
+  memcpy (string_ptr, name, namelen);
+  string_ptr[namelen] = 0;
+  string_ptr += namelen + 1;
+
+  ret->h_addr_list[0] = string_ptr;
+  if (addrsize_in != addrsize_out) {
+    memcpy4to6 (string_ptr, address);
+    ret->h_addrtype = AF_INET6;
+  }
+  else
+    memcpy (string_ptr, address, addrsize_out);
+
+  ret->h_aliases[alias_count] = NULL;
+  ret->h_addr_list[address_count] = NULL;
+
+  return ret;
+}
+
  static hostent *
  gethostby_helper (const char *name, const int af, const int type,
                   const int addrsize_in, const int addrsize_out)
@@ -1352,8 +1444,10 @@ gethostby_helper (const char *name, cons
               string_ptr += curptr->namelen1;
             }
           ret->h_addr_list[address_count++] = string_ptr;
-         if (addrsize_in != addrsize_out)
+         if (addrsize_in != addrsize_out) {
             memcpy4to6 (string_ptr, curptr->data);
+           ret->h_addrtype =  AF_INET6;
+         }
           else
             memcpy (string_ptr, curptr->data, addrsize_in);
           string_ptr += addrsize_out;
@@ -1405,7 +1499,10 @@ gethostbyname2 (const char *name, int af
           __leave;
         }

-      res = gethostby_helper (name, af, type, addrsize_in, addrsize_out);
+      h_errno = NETDB_SUCCESS;
+      res = gethostby_specials (name, af, addrsize_in, addrsize_out);
+      if ((res == NULL) && (h_errno == NETDB_SUCCESS))
+         res = gethostby_helper (name, af, type, addrsize_in, addrsize_out);
      }
    __except (EFAULT) {}
    __endtry

--=====================_84710711==_
Content-Type: application/octet-stream; name="net.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="net.cc.diff"
Content-length: 5958

SW5kZXg6IG5ldC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9uZXQuY2MsdgpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuMzIyCmRpZmYgLXUgLXAgLXIxLjMyMiBuZXQuY2MK
LS0tIG5ldC5jYwkyMCBKYW4gMjAxNSAxODoyMzoxOSAtMDAwMAkxLjMyMgor
KysgbmV0LmNjCTIzIEphbiAyMDE1IDAwOjAzOjQ1IC0wMDAwCkBAIC03Miw2
ICs3Miw3IEBAIGV4dGVybiAiQyIKICAgaW50IF9fc3RkY2FsbCByY21kIChj
aGFyICoqYWhvc3QsIHVuc2lnbmVkIHNob3J0IGlucG9ydCwgY2hhciAqbG9j
dXNlciwKIAkJICAgICAgY2hhciAqcmVtdXNlciwgY2hhciAqY21kLCBTT0NL
RVQgKiBmZDJwKTsKICAgaW50IHNzY2FuZiAoY29uc3QgY2hhciAqLCBjb25z
dCBjaGFyICosIC4uLik7CisgIGludCBjeWd3aW5faW5ldF9wdG9uKGludCwg
Y29uc3QgY2hhciAqLCB2b2lkICopOwogICBpbnQgY3lnd2luX2luZXRfYXRv
bihjb25zdCBjaGFyICosIHN0cnVjdCBpbl9hZGRyICopOwogICBjb25zdCBj
aGFyICpjeWd3aW5faW5ldF9udG9wIChpbnQsIGNvbnN0IHZvaWQgKiwgY2hh
ciAqLCBzb2NrbGVuX3QpOwogICBpbnQgZG5fbGVuZ3RoMShjb25zdCB1bnNp
Z25lZCBjaGFyICosIGNvbnN0IHVuc2lnbmVkIGNoYXIgKiwKQEAgLTExNjgs
NiArMTE2OSw5NyBAQCBtZW1jcHk0dG82IChjaGFyICpkc3QsIGNvbnN0IHVf
Y2hhciAqc3JjCiAgIG1lbWNweSAoZHN0ICsgMTIsIHNyYywgTlNfSU5BRERS
U1opOwogfQogCisvKiBnZXRob3N0Ynlfc3BlY2lhbHM6IFJGQyA2NzYxIAor
ICAgSGFuZGxlcyBudW1lcmljYWwgYWRkcmVzc2VzIGFuZCBzcGVjaWFsIG5h
bWVzIGZvciBnZXRob3N0YnluYW1lMiAqLyAKK3N0YXRpYyBob3N0ZW50ICoK
K2dldGhvc3RieV9zcGVjaWFscyAoY29uc3QgY2hhciAqbmFtZSwgY29uc3Qg
aW50IGFmLAorCQkgICAgY29uc3QgaW50IGFkZHJzaXplX2luLCBjb25zdCBp
bnQgYWRkcnNpemVfb3V0KQoreworICBpbnQgbmFtZWxlbiA9IHN0cmxlbiAo
bmFtZSk7CisgIC8qIElnbm9yZSBhIGZpbmFsICcuJyAqLworICBpZiAoKG5h
bWVsZW4gPT0gMCkgfHwgKChuYW1lbGVuIC09IChuYW1lW25hbWVsZW4gLSAx
XSA9PSAnLicpKSA9PSAwKSkgIHsKKyAgICBzZXRfZXJybm8gKEVJTlZBTCk7
CisgICAgaF9lcnJubyA9IE5FVERCX0lOVEVSTkFMOworICAgIHJldHVybiBO
VUxMOworICB9CisKKyAgaW50IHJlczsKKyAgdV9jaGFyIGFkZHJlc3NbTlNf
SU42QUREUlNaXTsKKyAgLyogVGVzdCBmb3IgbnVtZXJpY2FsIGFkZHJlc3Nl
cyAqLworICByZXMgPSBjeWd3aW5faW5ldF9wdG9uKGFmLCBuYW1lLCBhZGRy
ZXNzKTsKKyAgLyogVGVzdCBmb3Igc3BlY2lhbCBkb21haW4gbmFtZXMgKi8K
KyAgaWYgKHJlcyAhPSAxKSB7CisgICAgeworICAgICAgY2hhciBjb25zdCBt
YXRjaFtdID0gImludmFsaWQiOworICAgICAgaW50IGNvbnN0IG1hdGNobGVu
ID0gc2l6ZW9mKG1hdGNoKSAtIDE7CisgICAgICBpbnQgc3RhcnQgPSBuYW1l
bGVuIC0gbWF0Y2hsZW47CisgICAgICBpZiAoKHN0YXJ0ID49IDApICYmICgo
c3RhcnQgPT0gMCkgfHwgKG5hbWVbc3RhcnQtMV0gPT0gJy4nKSkKKwkgICYm
IChzdHJuY2FzZWNtcCAoJm5hbWVbc3RhcnRdLCBtYXRjaCAsIG1hdGNobGVu
KSA9PSAwKSkgeworCWhfZXJybm8gPSBIT1NUX05PVF9GT1VORDsKKwlyZXR1
cm4gTlVMTDsKKyAgICAgIH0KKyAgICB9CisgICAgeworICAgICAgY2hhciBj
b25zdCBtYXRjaFtdID0gImxvY2FsaG9zdCI7CisgICAgICBpbnQgY29uc3Qg
bWF0Y2hsZW4gPSBzaXplb2YobWF0Y2gpIC0gMTsKKyAgICAgIGludCBzdGFy
dCA9IG5hbWVsZW4gLSBtYXRjaGxlbjsKKyAgICAgIGlmICgoc3RhcnQgPj0g
MCkgJiYgKChzdGFydCA9PSAwKSB8fCAobmFtZVtzdGFydC0xXSA9PSAnLicp
KQorCSAgJiYgKHN0cm5jYXNlY21wICgmbmFtZVtzdGFydF0sIG1hdGNoICwg
bWF0Y2hsZW4pID09IDApKSB7CisJcmVzID0gMTsKKwlpZiAoYWYgPT0gQUZf
SU5FVCkgeworCSAgYWRkcmVzc1swXSA9IDEyNzsKKwkgIGFkZHJlc3NbMV0g
PSBhZGRyZXNzWzJdID0gMDsKKwkgIGFkZHJlc3NbM10gPSAxOworCX0KKwll
bHNlIHsKKwkgIG1lbXNldCAoYWRkcmVzcywgMCwgTlNfSU42QUREUlNaKTsK
KwkgIGFkZHJlc3NbTlNfSU42QUREUlNaLTFdID0gMTsKKwl9CisgICAgICB9
CisgICAgfQorICB9CisgIGlmIChyZXMgIT0gMSkKKyAgICByZXR1cm4gTlVM
TDsgIAorCisgIGludCBjb25zdCBhbGlhc19jb3VudCA9IDAsIGFkZHJlc3Nf
Y291bnQgPSAxOworICBjaGFyICogc3RyaW5nX3B0cjsKKyAgaW50IHN6ID0g
RFdPUkRfcm91bmQgKHNpemVvZihob3N0ZW50KSkKKyAgICArIHNpemVvZiAo
Y2hhciAqKSAqIChhbGlhc19jb3VudCArIGFkZHJlc3NfY291bnQgKyAyKQor
ICAgICsgbmFtZWxlbiArIDEKKyAgICArIGFkZHJlc3NfY291bnQgKiBhZGRy
c2l6ZV9vdXQ7CisgIGhvc3RlbnQgKnJldCA9IHJlYWxsb2NfZW50IChzeiwg
IChob3N0ZW50ICopIE5VTEwpOworICBpZiAoIXJldCkKKyAgICB7CisgICAg
ICAvKiBlcnJubyBpcyBhbHJlYWR5IHNldCAqLworICAgICAgaF9lcnJubyA9
IE5FVERCX0lOVEVSTkFMOworICAgICAgcmV0dXJuIE5VTEw7CisgICAgfQor
CisgIHJldC0+aF9hZGRydHlwZSA9IGFmOworICByZXQtPmhfbGVuZ3RoID0g
YWRkcnNpemVfb3V0OworICByZXQtPmhfYWxpYXNlcyA9IChjaGFyICoqKSAo
KChjaGFyICopIHJldCkgKyBEV09SRF9yb3VuZCAoc2l6ZW9mKGhvc3RlbnQp
KSk7CisgIHJldC0+aF9hZGRyX2xpc3QgPSByZXQtPmhfYWxpYXNlcyArIGFs
aWFzX2NvdW50ICsgMTsKKyAgc3RyaW5nX3B0ciA9IChjaGFyICopIChyZXQt
PmhfYWRkcl9saXN0ICsgYWRkcmVzc19jb3VudCArIDEpOworICByZXQtPmhf
bmFtZSA9IHN0cmluZ19wdHI7CisKKyAgbWVtY3B5IChzdHJpbmdfcHRyLCBu
YW1lLCBuYW1lbGVuKTsKKyAgc3RyaW5nX3B0cltuYW1lbGVuXSA9IDA7Cisg
IHN0cmluZ19wdHIgKz0gbmFtZWxlbiArIDE7CisKKyAgcmV0LT5oX2FkZHJf
bGlzdFswXSA9IHN0cmluZ19wdHI7CisgIGlmIChhZGRyc2l6ZV9pbiAhPSBh
ZGRyc2l6ZV9vdXQpIHsKKyAgICBtZW1jcHk0dG82IChzdHJpbmdfcHRyLCBh
ZGRyZXNzKTsKKyAgICByZXQtPmhfYWRkcnR5cGUgPSBBRl9JTkVUNjsKKyAg
fQorICBlbHNlCisgICAgbWVtY3B5IChzdHJpbmdfcHRyLCBhZGRyZXNzLCBh
ZGRyc2l6ZV9vdXQpOworCisgIHJldC0+aF9hbGlhc2VzW2FsaWFzX2NvdW50
XSA9IE5VTEw7CisgIHJldC0+aF9hZGRyX2xpc3RbYWRkcmVzc19jb3VudF0g
PSBOVUxMOworCisgIHJldHVybiByZXQ7Cit9CisKIHN0YXRpYyBob3N0ZW50
ICoKIGdldGhvc3RieV9oZWxwZXIgKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0
IGludCBhZiwgY29uc3QgaW50IHR5cGUsCiAJCSAgY29uc3QgaW50IGFkZHJz
aXplX2luLCBjb25zdCBpbnQgYWRkcnNpemVfb3V0KQpAQCAtMTM1Miw4ICsx
NDQ0LDEwIEBAIGdldGhvc3RieV9oZWxwZXIgKGNvbnN0IGNoYXIgKm5hbWUs
IGNvbnMKIAkgICAgICBzdHJpbmdfcHRyICs9IGN1cnB0ci0+bmFtZWxlbjE7
CiAJICAgIH0KIAkgIHJldC0+aF9hZGRyX2xpc3RbYWRkcmVzc19jb3VudCsr
XSA9IHN0cmluZ19wdHI7Ci0JICBpZiAoYWRkcnNpemVfaW4gIT0gYWRkcnNp
emVfb3V0KQorCSAgaWYgKGFkZHJzaXplX2luICE9IGFkZHJzaXplX291dCkg
ewogCSAgICBtZW1jcHk0dG82IChzdHJpbmdfcHRyLCBjdXJwdHItPmRhdGEp
OworCSAgICByZXQtPmhfYWRkcnR5cGUgPSAgQUZfSU5FVDY7CisJICB9CiAJ
ICBlbHNlCiAJICAgIG1lbWNweSAoc3RyaW5nX3B0ciwgY3VycHRyLT5kYXRh
LCBhZGRyc2l6ZV9pbik7CiAJICBzdHJpbmdfcHRyICs9IGFkZHJzaXplX291
dDsKQEAgLTE0MDUsNyArMTQ5OSwxMCBAQCBnZXRob3N0YnluYW1lMiAoY29u
c3QgY2hhciAqbmFtZSwgaW50IGFmCiAJICBfX2xlYXZlOwogCX0KIAotICAg
ICAgcmVzID0gZ2V0aG9zdGJ5X2hlbHBlciAobmFtZSwgYWYsIHR5cGUsIGFk
ZHJzaXplX2luLCBhZGRyc2l6ZV9vdXQpOworICAgICAgaF9lcnJubyA9IE5F
VERCX1NVQ0NFU1M7CisgICAgICByZXMgPSBnZXRob3N0Ynlfc3BlY2lhbHMg
KG5hbWUsIGFmLCBhZGRyc2l6ZV9pbiwgYWRkcnNpemVfb3V0KTsKKyAgICAg
IGlmICgocmVzID09IE5VTEwpICYmIChoX2Vycm5vID09IE5FVERCX1NVQ0NF
U1MpKQorCSAgcmVzID0gZ2V0aG9zdGJ5X2hlbHBlciAobmFtZSwgYWYsIHR5
cGUsIGFkZHJzaXplX2luLCBhZGRyc2l6ZV9vdXQpOwogICAgIH0KICAgX19l
eGNlcHQgKEVGQVVMVCkge30KICAgX19lbmR0cnkK

--=====================_84710711==_--
