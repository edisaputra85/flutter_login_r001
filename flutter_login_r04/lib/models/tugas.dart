class Tugas {
  String matakuliah;
  String uraianTugas;
  String deadline;
  String status;

  Tugas(this.matakuliah, this.uraianTugas, this.deadline, this.status);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map['matakuliah'] = this.matakuliah;
    map['uraian_tugas'] = this.uraianTugas;
    map['deadline'] = this.deadline;
    map['status'] = this.status;
    return map;
  }
}
