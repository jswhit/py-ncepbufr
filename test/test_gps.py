import ncepbufr

hdrstr ='YEAR MNTH DAYS HOUR MINU PCCF ELRC SAID PTID GEODU'

# read amsua radiance file.

bufr = ncepbufr.open('../test/gpsbufr')
bufr.print_table()
print_data = True
for subset in bufr:
    print bufr.subset_counter, bufr.subset_type, bufr.subset_date
    while (bufr.load_subset() == 0):
        hdr = bufr.read_subset(hdrstr)
        yyyymmddhh ='%04i%02i%02i%02i%02i' % tuple(hdr[0:5])
        satid = int(hdr[7].item())
        ptid = int(hdr[8].item())
        nreps_this_ROSEQ2 = bufr.read_subset('{ROSEQ2}').squeeze()
        nreps_this_ROSEQ1 = len(nreps_this_ROSEQ2)
        data1b = bufr.read_subset('ROSEQ1',seq=True)
        data2a = bufr.read_subset('ROSEQ3',seq=True) # refractivity
        levs_bend = data1b.shape[1]
        levs_ref = data2a.shape[1]
        if levs_ref != levs_bend:
            print 'skip report due to bending angle/refractivity mismatch'
            continue
        print 'sat id,platform transitter id, levels, yyyymmddhhmm =',\
        satid,ptid,levs_ref,yyyymmddhh
        if print_data: # print data from first subset with data
            print 'k, height, lat, lon, ref, bend:'
            for k in xrange(levs_ref):
                rlat = data1b[0,k]
                rlon = data1b[1,k]
                height = data2a[0,k]
                ref = data2a[1,k]
                for i in xrange(int(nreps_this_ROSEQ2[k])):
                    m = 6*(i+1)-3
                    freq = data1b[m,k]
                    bend = data1b[m+2,k]
                    # look for zero frequency bending angle ob
                    if int(freq) == 0: break
                print k,rlat,rlon,height,ref,bend
            print_data = False
bufr.close()